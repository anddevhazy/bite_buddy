import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/codes.dart';
import '../utils/pet_stats.dart' as stats;
import 'pet_service.dart';

class FriendService {
  final PetService pets;

  const FriendService({required this.pets});

  // Friends plus pending requests either way
  static const int maxFriends = 100;

  Future<String> myCode(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    return pet.friendCode!;
  }

  // Incoming requests first, then friends by shared streak, then requests
  // you've sent
  Future<List<Friend>> list(Session session, UuidValue ownerId) async {
    final me = await pets.requireMine(session, ownerId);
    final rows = await Friendship.db.find(
      session,
      where: (t) => t.requesterId.equals(ownerId) | t.addresseeId.equals(ownerId),
    );
    final petsByOwner = await _petsOf(session, [
      for (final f in rows) _other(f, ownerId),
    ]);
    final today = stats.localDay(DateTime.now(), me.utcOffsetMinutes);

    final friends = [
      for (final f in rows)
        if (petsByOwner[_other(f, ownerId)] case final pet?)
          _toFriend(f, ownerId, pet, today),
    ];
    int order(FriendStatus s) => switch (s) {
      FriendStatus.incoming => 0,
      FriendStatus.friends => 1,
      FriendStatus.outgoing => 2,
    };
    friends.sort((a, b) {
      final byStatus = order(a.status).compareTo(order(b.status));
      if (byStatus != 0) return byStatus;
      final byStreak = b.sharedStreak.compareTo(a.sharedStreak);
      if (byStreak != 0) return byStreak;
      return a.petName.toLowerCase().compareTo(b.petName.toLowerCase());
    });
    return friends;
  }

  // Sends a request to the owner of [code]. If they'd already asked you, this
  // accepts theirs instead.
  Future<Friend> add(Session session, UuidValue ownerId, String code) async {
    final me = await pets.requireMine(session, ownerId);
    final target = await Pet.db.findFirstRow(
      session,
      where: (t) => t.friendCode.equals(normalizeCode(code)),
    );
    if (target == null) {
      throw conflictError('NOT_FOUND', 'No buddy has that friend code.');
    }
    if (target.ownerId == ownerId) {
      throw invalidInputError("That's your own friend code!");
    }
    final today = stats.localDay(DateTime.now(), me.utcOffsetMinutes);

    final existing = await _pair(session, ownerId, target.ownerId);
    if (existing != null) {
      if (existing.accepted) {
        throw conflictError('ALREADY_FRIENDS', "You're already friends.");
      }
      if (existing.requesterId == ownerId) {
        throw conflictError(
          'ALREADY_ASKED',
          'Request already sent. Waiting for them to accept.',
        );
      }
      final accepted = await Friendship.db.updateRow(
        session,
        existing.copyWith(accepted: true),
      );
      return _toFriend(accepted, ownerId, target, today);
    }

    final count = await Friendship.db.count(
      session,
      where: (t) => t.requesterId.equals(ownerId) | t.addresseeId.equals(ownerId),
    );
    if (count >= maxFriends) {
      throw conflictError(
        'TOO_MANY_FRIENDS',
        'You can have up to $maxFriends friends and requests.',
      );
    }

    final row = await Friendship.db.insertRow(
      session,
      Friendship(
        requesterId: ownerId,
        addresseeId: target.ownerId,
        accepted: false,
        sharedStreak: 0,
        sharedStreakDay: null,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return _toFriend(row, ownerId, target, today);
  }

  Future<Friend> accept(
    Session session,
    UuidValue ownerId,
    int friendshipId,
  ) async {
    final me = await pets.requireMine(session, ownerId);
    final row = await Friendship.db.findById(session, friendshipId);
    if (row == null || row.addresseeId != ownerId || row.accepted) {
      throw notFoundError('Friend request');
    }
    final pet = (await _petsOf(session, [row.requesterId]))[row.requesterId];
    if (pet == null) throw notFoundError('Friend request');

    final accepted = await Friendship.db.updateRow(
      session,
      row.copyWith(accepted: true),
    );
    final today = stats.localDay(DateTime.now(), me.utcOffsetMinutes);
    return _toFriend(accepted, ownerId, pet, today);
  }

  // Unfriend, decline an incoming request, or cancel one you sent
  Future<void> remove(
    Session session,
    UuidValue ownerId,
    int friendshipId,
  ) async {
    final row = await Friendship.db.findById(session, friendshipId);
    if (row == null ||
        (row.requesterId != ownerId && row.addresseeId != ownerId)) {
      throw notFoundError('Friend');
    }
    await Friendship.db.deleteRow(session, row);
  }

  Future<bool> areFriends(
    Session session,
    UuidValue a,
    UuidValue b, {
    Transaction? transaction,
  }) async {
    final row = await _pair(session, a, b, transaction: transaction);
    return row?.accepted ?? false;
  }

  // The pets of everyone [ownerId] is friends with
  Future<List<Pet>> friendPets(
    Session session,
    UuidValue ownerId, {
    Transaction? transaction,
  }) async {
    final rows = await _accepted(session, ownerId, transaction: transaction);
    final petsByOwner = await _petsOf(session, [
      for (final f in rows) _other(f, ownerId),
    ], transaction: transaction);
    return petsByOwner.values.toList();
  }

  // Called when [ownerId] feeds on a new streak [today]. Every friend who has
  // already fed today extends their shared streak.
  Future<void> recordFeedDay(
    Session session,
    UuidValue ownerId,
    DateTime today, {
    required Transaction transaction,
  }) async {
    final rows = await _accepted(session, ownerId, transaction: transaction);
    if (rows.isEmpty) return;
    final petsByOwner = await _petsOf(session, [
      for (final f in rows) _other(f, ownerId),
    ], transaction: transaction);

    for (final f in rows) {
      final friendPet = petsByOwner[_other(f, ownerId)];
      // Compares against the friend's own local day, which is the same
      // calendar day unless they live in a very different time zone
      if (friendPet?.lastStreakDay != today) continue;
      final bumped = stats.bumpSharedStreak(f, today);
      if (bumped.sharedStreakDay != f.sharedStreakDay) {
        await Friendship.db.updateRow(session, bumped, transaction: transaction);
      }
    }
  }

  Future<List<Friendship>> _accepted(
    Session session,
    UuidValue ownerId, {
    Transaction? transaction,
  }) => Friendship.db.find(
    session,
    where: (t) =>
        (t.requesterId.equals(ownerId) | t.addresseeId.equals(ownerId)) &
        t.accepted.equals(true),
    transaction: transaction,
  );

  Future<Friendship?> _pair(
    Session session,
    UuidValue a,
    UuidValue b, {
    Transaction? transaction,
  }) => Friendship.db.findFirstRow(
    session,
    where: (t) =>
        (t.requesterId.equals(a) & t.addresseeId.equals(b)) |
        (t.requesterId.equals(b) & t.addresseeId.equals(a)),
    transaction: transaction,
  );

  Future<Map<UuidValue, Pet>> _petsOf(
    Session session,
    List<UuidValue> ownerIds, {
    Transaction? transaction,
  }) async {
    if (ownerIds.isEmpty) return {};
    final found = await Pet.db.find(
      session,
      where: (t) => t.ownerId.inSet(ownerIds.toSet()),
      transaction: transaction,
    );
    return {for (final p in found) p.ownerId: p};
  }

  UuidValue _other(Friendship f, UuidValue me) =>
      f.requesterId == me ? f.addresseeId : f.requesterId;

  Friend _toFriend(Friendship f, UuidValue me, Pet pet, DateTime today) =>
      Friend(
        friendshipId: f.id!,
        status: f.accepted
            ? FriendStatus.friends
            : f.requesterId == me
            ? FriendStatus.outgoing
            : FriendStatus.incoming,
        petId: pet.id!,
        petName: pet.name,
        speciesKey: pet.speciesKey,
        level: pet.level,
        nutrition: pet.nutrition,
        // Stored streaks only reset when the pet is next loaded by its owner
        streak: stats.expireStreak(pet, DateTime.now().toUtc()).streak,
        sharedStreak: f.accepted ? stats.currentSharedStreak(f, today) : 0,
      );
}

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/pet_stats.dart';
import '../utils/shared_streak.dart';
import 'pet_service.dart';

// Shared streaks with league friends. A day counts once both friends have
// fed their buddy, and every day it grows both get a few coins.
class StreakService {
  final PetService pets;

  const StreakService({required this.pets});

  Future<List<StreakBuddyView>> mine(Session session, UuidValue userId) async {
    final buddies = await StreakBuddy.db.find(
      session,
      where: (t) => t.aUserId.equals(userId) | t.bUserId.equals(userId),
      orderByList: (t) => [t.createdAt.asc()],
    );
    if (buddies.isEmpty) return [];
    final petsByOwner = await _pets(session, {
      userId,
      for (final b in buddies) _friendOf(b, userId),
    });
    return [
      for (final b in buddies) ?_view(b, userId, petsByOwner),
    ];
  }

  // League friends the caller doesn't have a shared streak or invite with yet
  Future<List<StreakFriend>> candidates(
    Session session,
    UuidValue userId,
  ) async {
    final friendIds = await _leagueFriends(session, userId);
    final taken = {
      for (final b in await StreakBuddy.db.find(
        session,
        where: (t) => t.aUserId.equals(userId) | t.bUserId.equals(userId),
      ))
        _friendOf(b, userId),
    };
    friendIds.removeAll(taken);
    if (friendIds.isEmpty) return [];
    final friendPets = await _pets(session, friendIds);
    return [
      for (final pet in friendPets.values)
        StreakFriend(
          userId: pet.ownerId,
          petName: pet.name,
          speciesKey: pet.speciesKey,
          portraitId: pet.portraitId,
        ),
    ]..sort((a, b) => a.petName.compareTo(b.petName));
  }

  Future<StreakBuddyView> invite(
    Session session,
    UuidValue userId,
    UuidValue friendId,
  ) async {
    if (friendId == userId) {
      throw invalidInputError("You can't start a streak with yourself.");
    }
    await pets.requireMine(session, userId);
    if (!(await _leagueFriends(session, userId)).contains(friendId)) {
      throw notFoundError('League friend');
    }

    final buddy = await session.db.transaction((transaction) async {
      final existing = await StreakBuddy.db.find(
        session,
        where: (t) => t.aUserId.equals(userId) | t.bUserId.equals(userId),
        transaction: transaction,
      );
      if (existing.any((b) => _friendOf(b, userId) == friendId)) {
        throw conflictError(
          'STREAK_EXISTS',
          'You already have a streak or invite with this friend.',
        );
      }
      if (existing.length >= maxStreakBuddies) {
        throw conflictError(
          'TOO_MANY_STREAKS',
          'You can have up to $maxStreakBuddies shared streaks.',
        );
      }
      return StreakBuddy.db.insertRow(
        session,
        StreakBuddy(
          aUserId: userId,
          bUserId: friendId,
          accepted: false,
          streak: 0,
          bestStreak: 0,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
    });
    return _viewOne(session, buddy, userId);
  }

  // Only the invited friend can accept
  Future<StreakBuddyView> accept(
    Session session,
    UuidValue userId,
    int buddyId,
  ) async {
    final buddy = await StreakBuddy.db.findById(session, buddyId);
    if (buddy == null || buddy.bUserId != userId) {
      throw notFoundError('Streak invite');
    }
    if (buddy.accepted) return _viewOne(session, buddy, userId);

    final count = await StreakBuddy.db.count(
      session,
      where: (t) =>
          t.accepted.equals(true) &
          (t.aUserId.equals(userId) | t.bUserId.equals(userId)),
    );
    if (count >= maxStreakBuddies) {
      throw conflictError(
        'TOO_MANY_STREAKS',
        'You can have up to $maxStreakBuddies shared streaks.',
      );
    }
    final saved = await StreakBuddy.db.updateRow(
      session,
      buddy.copyWith(accepted: true),
    );
    return _viewOne(session, saved, userId);
  }

  // Declines an invite, cancels one, or ends a streak. Either friend can.
  Future<void> remove(Session session, UuidValue userId, int buddyId) async {
    final buddy = await StreakBuddy.db.findById(session, buddyId);
    if (buddy == null || (buddy.aUserId != userId && buddy.bUserId != userId)) {
      throw notFoundError('Shared streak');
    }
    await StreakBuddy.db.deleteRow(session, buddy);
  }

  // Called from feeding, inside its transaction, with the feeder's local
  // [day]. Returns the friends whose shared streak grew; the caller pays
  // them with [payFriends] once its transaction has committed.
  Future<List<UuidValue>> recordFeed(
    Session session,
    UuidValue ownerId,
    DateTime day,
    Transaction transaction,
  ) async {
    // Locked, so two friends feeding at the same moment can't both miss
    // that the other has fed
    final buddies = await StreakBuddy.db.find(
      session,
      where: (t) =>
          t.accepted.equals(true) &
          (t.aUserId.equals(ownerId) | t.bUserId.equals(ownerId)),
      lockMode: LockMode.forUpdate,
      transaction: transaction,
    );
    final grew = <UuidValue>[];
    for (final buddy in buddies) {
      final result = recordSharedFeed(
        buddy,
        isA: buddy.aUserId == ownerId,
        day: day,
      );
      await StreakBuddy.db.updateRow(
        session,
        result.buddy,
        transaction: transaction,
      );
      if (result.extended) grew.add(_friendOf(buddy, ownerId));
    }
    return grew;
  }

  // An atomic increment outside the feeding transaction, so it can't
  // deadlock with the friend feeding at the same time
  Future<void> payFriends(Session session, List<UuidValue> friendIds) async {
    for (final id in friendIds) {
      await session.db.unsafeExecute(
        'UPDATE "pet" SET "coins" = "coins" + @coins WHERE "ownerId" = @owner',
        parameters: QueryParameters.named({
          'coins': sharedStreakCoins,
          'owner': id.toString(),
        }),
      );
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  Future<StreakBuddyView> _viewOne(
    Session session,
    StreakBuddy buddy,
    UuidValue userId,
  ) async {
    final petsByOwner = await _pets(session, {
      buddy.aUserId,
      buddy.bUserId,
    });
    final view = _view(buddy, userId, petsByOwner);
    if (view == null) throw notFoundError('Shared streak');
    return view;
  }

  // Null if either friend has no pet (e.g. a deleted account)
  StreakBuddyView? _view(
    StreakBuddy buddy,
    UuidValue userId,
    Map<UuidValue, Pet> petsByOwner,
  ) {
    final isA = buddy.aUserId == userId;
    final me = petsByOwner[userId];
    final friend = petsByOwner[_friendOf(buddy, userId)];
    if (me == null || friend == null) return null;

    final now = DateTime.now().toUtc();
    final myToday = localDay(now, me.utcOffsetMinutes);
    final friendToday = localDay(now, friend.utcOffsetMinutes);
    final myLast = isA ? buddy.aLastFedDay : buddy.bLastFedDay;
    final friendLast = isA ? buddy.bLastFedDay : buddy.aLastFedDay;
    return StreakBuddyView(
      id: buddy.id!,
      status: buddy.accepted
          ? StreakBuddyStatus.active
          : isA
          ? StreakBuddyStatus.invited
          : StreakBuddyStatus.incoming,
      friendPetName: friend.name,
      friendSpeciesKey: friend.speciesKey,
      friendPortraitId: friend.portraitId,
      streak: liveSharedStreak(buddy, pairToday(myToday, friendToday)),
      bestStreak: buddy.bestStreak,
      youFedToday: myLast == myToday,
      friendFedToday: friendLast == friendToday,
    );
  }

  UuidValue _friendOf(StreakBuddy buddy, UuidValue userId) =>
      buddy.aUserId == userId ? buddy.bUserId : buddy.aUserId;

  Future<Map<UuidValue, Pet>> _pets(
    Session session,
    Set<UuidValue> ids,
  ) async => {
    for (final p in await Pet.db.find(
      session,
      where: (t) => t.ownerId.inSet(ids),
    ))
      p.ownerId: p,
  };

  // Everyone who shares at least one league with the user
  Future<Set<UuidValue>> _leagueFriends(
    Session session,
    UuidValue userId,
  ) async {
    final leagueIds = (await LeagueMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    )).map((m) => m.leagueId).toSet();
    if (leagueIds.isEmpty) return {};
    return (await LeagueMember.db.find(
      session,
      where: (t) => t.leagueId.inSet(leagueIds),
    )).map((m) => m.userId).where((id) => id != userId).toSet();
  }
}

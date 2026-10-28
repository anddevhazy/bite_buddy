import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/codes.dart';
import 'pet_service.dart';

// Group challenges: whoever feeds the most healthy meals before the end wins.
// Anyone with the code can join, so friends can pass it around a group chat.
class ChallengeService {
  final PetService pets;

  const ChallengeService({required this.pets});

  static const int maxMembers = 30;
  static const int maxActivePerUser = 10;
  static const int maxDays = 30;
  static const int maxNameLength = 30;
  // A meal this good or better scores a point
  static const int healthyScore = 70;
  // The most challenges listed at once
  static const int recentLimit = 20;

  Future<ChallengeSummary> create(
    Session session,
    UuidValue ownerId,
    String name,
    int days,
  ) async {
    await pets.requireMine(session, ownerId);
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > maxNameLength) {
      throw invalidInputError(
        'Challenge names must be 1 to $maxNameLength characters.',
      );
    }
    if (days < 1 || days > maxDays) {
      throw invalidInputError('Challenges last 1 to $maxDays days.');
    }

    final challenge = await session.db.transaction((transaction) async {
      await _checkActiveLimit(session, ownerId, transaction);
      final now = DateTime.now().toUtc();
      final challenge = await Challenge.db.insertRow(
        session,
        Challenge(
          name: trimmed,
          code: await _unusedCode(session, transaction),
          ownerId: ownerId,
          startsAt: now,
          endsAt: now.add(Duration(days: days)),
          createdAt: now,
        ),
        transaction: transaction,
      );
      await ChallengeMember.db.insertRow(
        session,
        ChallengeMember(
          challengeId: challenge.id!,
          userId: ownerId,
          joinedAt: now,
        ),
        transaction: transaction,
      );
      return challenge;
    });
    return _summary(session, challenge, ownerId);
  }

  Future<ChallengeSummary> join(
    Session session,
    UuidValue ownerId,
    String code,
  ) async {
    await pets.requireMine(session, ownerId);
    final challenge = await Challenge.db.findFirstRow(
      session,
      where: (t) => t.code.equals(normalizeCode(code)),
    );
    if (challenge == null) {
      throw conflictError('NOT_FOUND', 'No challenge has that code.');
    }

    await session.db.transaction((transaction) async {
      final already = await ChallengeMember.db.count(
        session,
        where: (t) =>
            t.challengeId.equals(challenge.id!) & t.userId.equals(ownerId),
        transaction: transaction,
      );
      // Joining twice is harmless; just show it
      if (already > 0) return;

      if (!challenge.endsAt.isAfter(DateTime.now())) {
        throw conflictError('CHALLENGE_OVER', 'That challenge has ended.');
      }
      final members = await ChallengeMember.db.count(
        session,
        where: (t) => t.challengeId.equals(challenge.id!),
        transaction: transaction,
      );
      if (members >= maxMembers) {
        throw conflictError(
          'CHALLENGE_FULL',
          'That challenge is full ($maxMembers players).',
        );
      }
      await _checkActiveLimit(session, ownerId, transaction);
      await ChallengeMember.db.insertRow(
        session,
        ChallengeMember(
          challengeId: challenge.id!,
          userId: ownerId,
          joinedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
    });
    return _summary(session, challenge, ownerId);
  }

  // Running challenges first, then recently finished ones
  Future<List<ChallengeSummary>> mine(
    Session session,
    UuidValue ownerId,
  ) async {
    final memberships = await ChallengeMember.db.find(
      session,
      where: (t) => t.userId.equals(ownerId),
    );
    if (memberships.isEmpty) return [];

    final challenges = await Challenge.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final m in memberships) m.challengeId}),
      orderByList: (t) => [t.endsAt.desc()],
      limit: recentLimit,
    );
    final now = DateTime.now();
    challenges.sort((a, b) {
      final aOver = !a.endsAt.isAfter(now);
      final bOver = !b.endsAt.isAfter(now);
      if (aOver != bOver) return aOver ? 1 : -1;
      // Running: ending soonest first. Finished: most recent first.
      return aOver ? b.endsAt.compareTo(a.endsAt) : a.endsAt.compareTo(b.endsAt);
    });
    return [for (final c in challenges) await _summary(session, c, ownerId)];
  }

  Future<ChallengeSummary> get(
    Session session,
    UuidValue ownerId,
    int challengeId,
  ) async {
    final challenge = await _requireMember(session, ownerId, challengeId);
    return _summary(session, challenge, ownerId);
  }

  // The last member out deletes the challenge
  Future<void> leave(
    Session session,
    UuidValue ownerId,
    int challengeId,
  ) async {
    final challenge = await _requireMember(session, ownerId, challengeId);
    await session.db.transaction((transaction) async {
      await ChallengeMember.db.deleteWhere(
        session,
        where: (t) =>
            t.challengeId.equals(challengeId) & t.userId.equals(ownerId),
        transaction: transaction,
      );
      final left = await ChallengeMember.db.count(
        session,
        where: (t) => t.challengeId.equals(challengeId),
        transaction: transaction,
      );
      if (left == 0) {
        await Challenge.db.deleteRow(session, challenge, transaction: transaction);
      }
    });
  }

  Future<Challenge> _requireMember(
    Session session,
    UuidValue ownerId,
    int challengeId,
  ) async {
    final member = await ChallengeMember.db.count(
      session,
      where: (t) => t.challengeId.equals(challengeId) & t.userId.equals(ownerId),
    );
    final challenge = await Challenge.db.findById(session, challengeId);
    if (member == 0 || challenge == null) throw notFoundError('Challenge');
    return challenge;
  }

  Future<void> _checkActiveLimit(
    Session session,
    UuidValue ownerId,
    Transaction transaction,
  ) async {
    final memberships = await ChallengeMember.db.find(
      session,
      where: (t) => t.userId.equals(ownerId),
      transaction: transaction,
    );
    if (memberships.isEmpty) return;
    final active = await Challenge.db.count(
      session,
      where: (t) =>
          t.id.inSet(<int>{for (final m in memberships) m.challengeId}) &
          (t.endsAt > DateTime.now().toUtc()),
      transaction: transaction,
    );
    if (active >= maxActivePerUser) {
      throw conflictError(
        'TOO_MANY_CHALLENGES',
        'You can be in up to $maxActivePerUser running challenges.',
      );
    }
  }

  Future<ChallengeSummary> _summary(
    Session session,
    Challenge challenge,
    UuidValue callerId,
  ) async {
    final members = await ChallengeMember.db.find(
      session,
      where: (t) => t.challengeId.equals(challenge.id!),
    );
    final memberIds = {for (final m in members) m.userId};
    final memberPets = await Pet.db.find(
      session,
      where: (t) => t.ownerId.inSet(memberIds),
    );
    final meals = await Meal.db.find(
      session,
      where: (t) =>
          t.ownerId.inSet(memberIds) &
          t.fed.equals(true) &
          (t.healthScore >= healthyScore) &
          (t.createdAt >= challenge.startsAt) &
          (t.createdAt < challenge.endsAt),
    );

    final scores = <UuidValue, int>{};
    for (final m in meals) {
      scores[m.ownerId] = (scores[m.ownerId] ?? 0) + 1;
    }
    memberPets.sort((a, b) {
      final byScore = (scores[b.ownerId] ?? 0).compareTo(scores[a.ownerId] ?? 0);
      return byScore != 0 ? byScore : a.name.compareTo(b.name);
    });

    // Equal scores share a rank
    final standings = <ChallengeStanding>[];
    for (final (i, pet) in memberPets.indexed) {
      final score = scores[pet.ownerId] ?? 0;
      final rank = i > 0 && standings.last.score == score
          ? standings.last.rank
          : i + 1;
      standings.add(
        ChallengeStanding(
          rank: rank,
          petName: pet.name,
          speciesKey: pet.speciesKey,
          score: score,
          isYou: pet.ownerId == callerId,
        ),
      );
    }

    return ChallengeSummary(
      id: challenge.id!,
      name: challenge.name,
      code: challenge.code,
      startsAt: challenge.startsAt,
      endsAt: challenge.endsAt,
      isOwner: challenge.ownerId == callerId,
      standings: standings,
    );
  }

  Future<String> _unusedCode(Session session, Transaction transaction) async {
    while (true) {
      final code = newCode();
      final taken = await Challenge.db.count(
        session,
        where: (t) => t.code.equals(code),
        transaction: transaction,
      );
      if (taken == 0) return code;
    }
  }
}

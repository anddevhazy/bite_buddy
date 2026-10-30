import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../utils/memory_book.dart';
import 'pet_service.dart';

// The memory book. Almost everything in it comes from what the game already
// records (meals, battles, trophies, health syncs); only level-ups are
// recorded here, as they happen.
class MemoryService {
  final PetService pets;

  const MemoryService({required this.pets});

  // One row per level gained, e.g. 3 -> 5 records levels 4 and 5
  Future<void> recordLevelUps(
    Session session,
    UuidValue ownerId, {
    required int from,
    required int to,
    required Transaction transaction,
  }) async {
    if (to <= from) return;
    final now = DateTime.now().toUtc();
    await LevelUp.db.insert(session, [
      for (var level = from + 1; level <= to; level++)
        LevelUp(ownerId: ownerId, level: level, reachedAt: now),
    ], transaction: transaction);
  }

  Future<MemoryBook> book(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    final firstLeague = await LeagueMember.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(ownerId),
      orderBy: (t) => t.joinedAt,
    );
    final firstBigSteps = await ActivityDay.db.findFirstRow(
      session,
      where: (t) => t.ownerId.equals(ownerId) & (t.steps >= bigStepDay),
      orderBy: (t) => t.day,
    );
    final duelWins = await Duel.db.find(
      session,
      where: (t) =>
          t.status.equals(DuelStatus.finished) & t.winnerUserId.equals(ownerId),
    );

    return buildMemoryBook(
      MemoryInputs(
        pet: pet,
        fedMeals: await Meal.db.find(
          session,
          where: (t) => t.ownerId.equals(ownerId) & t.fed.equals(true),
        ),
        levelUps: await LevelUp.db.find(
          session,
          where: (t) => t.ownerId.equals(ownerId),
        ),
        arenaWins: await ArenaRun.db.find(
          session,
          where: (t) =>
              t.ownerId.equals(ownerId) &
              t.status.equals(ArenaRunStatus.won) &
              t.verified.equals(true),
        ),
        duelWins: [for (final d in duelWins) d.finishedAt ?? d.createdAt],
        trophies: await Trophy.db.find(
          session,
          where: (t) => t.userId.equals(ownerId),
        ),
        firstLeagueJoinedAt: firstLeague?.joinedAt,
        firstBigStepDay: firstBigSteps?.day,
        now: DateTime.now().toUtc(),
      ),
    );
  }
}

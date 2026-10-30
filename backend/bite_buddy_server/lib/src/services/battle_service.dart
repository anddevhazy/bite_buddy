import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/arena_rules.dart';
import '../utils/battle_engine.dart';
import '../utils/catalog.dart';
import '../utils/pet_stats.dart' as stats;
import 'pet_service.dart';

// Real-time fights against computer opponents. The fight runs on the phone;
// the server fixes both fighters when it starts, checks the reported result
// is possible, and pays out.
class BattleService {
  final PetService pets;
  final Random _rng;

  BattleService({required this.pets, Random? rng}) : _rng = rng ?? Random();

  Future<Arena> arena(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    final fighter = stats.petFighter(pet);
    return Arena(
      petStats: _stats(fighter),
      opponents: [for (final o in opponents) o.toProtocol()],
    );
  }

  Future<ArenaRunConfig> startRun(
    Session session,
    UuidValue ownerId,
    String opponentKey,
  ) async {
    final opponent = findOpponent(opponentKey);
    if (opponent == null) throw notFoundError('Opponent');

    return session.db.transaction((transaction) async {
      var pet = await pets.requireMine(
        session,
        ownerId,
        transaction: transaction,
      );
      if (pet.energy < stats.battleEnergyCost) {
        throw conflictError(
          'NOT_ENOUGH_ENERGY',
          'Your buddy is too tired to battle. Feed them a meal first!',
        );
      }

      // One fight at a time: an unfinished one counts as a loss
      final unfinished = await ArenaRun.db.find(
        session,
        where: (t) =>
            t.ownerId.equals(ownerId) & t.status.equals(ArenaRunStatus.ongoing),
        transaction: transaction,
      );
      for (final run in unfinished) {
        (_, pet, _) = await _settle(
          session,
          run,
          pet,
          won: false,
          verified: true,
          transaction: transaction,
        );
      }

      final fighter = stats.petFighter(pet);
      final run = await ArenaRun.db.insertRow(
        session,
        ArenaRun(
          ownerId: ownerId,
          petId: pet.id!,
          opponentKey: opponent.key,
          petMaxHp: fighter.maxHp,
          petAttack: fighter.attack,
          petDefense: fighter.defense,
          startedAt: DateTime.now().toUtc(),
          status: ArenaRunStatus.ongoing,
        ),
        transaction: transaction,
      );
      return ArenaRunConfig(
        runId: run.id!,
        petName: pet.name,
        petSpeciesKey: pet.speciesKey,
        petStats: _stats(fighter),
        opponent: opponent.toProtocol(),
        rules: arenaRules(),
        seed: _rng.nextInt(1 << 31),
      );
    });
  }

  Future<ArenaRunResult> finishRun(
    Session session,
    UuidValue ownerId,
    int runId,
    ArenaRunReport report,
  ) async {
    return session.db.transaction((transaction) async {
      final run = await ArenaRun.db.findById(
        session,
        runId,
        transaction: transaction,
      );
      if (run == null || run.ownerId != ownerId) {
        throw notFoundError('Battle');
      }
      if (run.status != ArenaRunStatus.ongoing) {
        throw conflictError('BATTLE_OVER', 'This battle is already over.');
      }
      final opponent = findOpponent(run.opponentKey)!;
      final pet = await pets.requireMine(
        session,
        ownerId,
        transaction: transaction,
      );

      final elapsed = DateTime.now().toUtc().difference(run.startedAt);
      final plausible =
          report.won &&
          elapsed <= maxRunLength &&
          winIsPlausible(
            report: report,
            serverElapsedMs: elapsed.inMilliseconds,
            pet: Fighter(
              maxHp: run.petMaxHp,
              attack: run.petAttack,
              defense: run.petDefense,
            ),
            opponent: opponent.fighter,
            rules: arenaRules(),
          );
      if (report.won && !plausible) {
        session.log(
          'Arena win rejected for run $runId: ${report.toJson()}, '
          'server elapsed ${elapsed.inMilliseconds}ms',
          level: LogLevel.warning,
        );
      }

      final (saved, _, leveledUp) = await _settle(
        session,
        run.copyWith(
          durationMs: report.durationMs,
          damageDealt: report.damageDealt,
          damageTaken: report.damageTaken,
        ),
        pet,
        won: plausible,
        verified: !report.won || plausible,
        transaction: transaction,
      );
      return ArenaRunResult(
        won: plausible,
        verified: saved.verified,
        coinsEarned: saved.coinsEarned,
        xpEarned: saved.xpEarned,
        energyChange: saved.energyChange,
        leveledUp: leveledUp,
      );
    });
  }

  // Ends the run, pays out rewards and saves both rows
  Future<(ArenaRun, Pet, bool)> _settle(
    Session session,
    ArenaRun run,
    Pet pet, {
    required bool won,
    required bool verified,
    required Transaction transaction,
  }) async {
    final opponent = findOpponent(run.opponentKey)!;
    final coins = won ? opponent.coinReward : 0;
    final xp = won ? 20 + opponent.level * 5 : 5;
    final energyChange = won ? stats.battleWinEnergy : -stats.battleEnergyCost;

    final rewarded = pet.copyWith(
      coins: pet.coins + coins,
      energy: stats.clampStat(pet.energy + energyChange),
      wins: pet.wins + (won ? 1 : 0),
      losses: pet.losses + (won ? 0 : 1),
    );
    final (leveled, leveledUp) = stats.addXp(rewarded, xp);
    final savedPet = await Pet.db.updateRow(
      session,
      leveled,
      transaction: transaction,
    );
    final savedRun = await ArenaRun.db.updateRow(
      session,
      run.copyWith(
        status: won ? ArenaRunStatus.won : ArenaRunStatus.lost,
        finishedAt: DateTime.now().toUtc(),
        verified: verified,
        coinsEarned: coins,
        xpEarned: xp,
        energyChange: savedPet.energy - pet.energy,
      ),
      transaction: transaction,
    );
    return (savedRun, savedPet, leveledUp);
  }

  BattleStats _stats(Fighter f) =>
      BattleStats(hp: f.maxHp, attack: f.attack, defense: f.defense);
}

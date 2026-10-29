import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/battle_engine.dart';
import '../utils/catalog.dart';
import '../utils/pet_stats.dart' as stats;
import 'pet_service.dart';

class BattleService {
  final PetService pets;
  final Random _rng;

  BattleService({required this.pets, Random? rng}) : _rng = rng ?? Random();

  // The arena: the pet's battle numbers and every opponent with an honest
  // win chance
  Future<Arena> arena(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    final fighter = stats.petFighter(pet);
    return Arena(
      petStats: BattleStats(
        hp: fighter.maxHp,
        attack: fighter.attack,
        defense: fighter.defense,
      ),
      opponents: [
        for (final o in opponents)
          o.toProtocol(winChance: _winChance(fighter, o)),
      ],
    );
  }

  Future<BattleState> start(
    Session session,
    UuidValue ownerId,
    String opponentKey,
  ) async {
    final opponent = findOpponent(opponentKey);
    if (opponent == null) throw notFoundError('Opponent');

    return session.db.transaction((transaction) async {
      final pet = await pets.requireMine(
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

      // Only one battle at a time: an unfinished one counts as a loss
      final unfinished = await Battle.db.find(
        session,
        where: (t) =>
            t.ownerId.equals(ownerId) & t.status.equals(BattleStatus.ongoing),
        transaction: transaction,
      );
      var current = pet;
      for (final b in unfinished) {
        final forfeited = await _finish(
          session,
          b,
          current,
          won: false,
          transaction: transaction,
        );
        current = forfeited.$2;
      }

      final maxHp = stats.petMaxHp(current);
      final (firstMove, firstTell) = _planOpponentMove(
        opponent,
        hp: opponent.hp,
        specialCooldown: 0,
      );
      final battle = await Battle.db.insertRow(
        session,
        Battle(
          ownerId: ownerId,
          petId: current.id!,
          opponentKey: opponent.key,
          petHp: maxHp,
          petMaxHp: maxHp,
          petAttack: stats.petAttack(current),
          petDefense: stats.petDefense(current),
          opponentHp: opponent.hp,
          opponentMaxHp: opponent.hp,
          round: 0,
          status: BattleStatus.ongoing,
          specialCooldown: 0,
          opponentSpecialCooldown: 0,
          opponentNextMove: firstMove,
          opponentTell: firstTell,
          lastRound: null,
          coinsEarned: 0,
          xpEarned: 0,
          energyChange: 0,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );

      return _state(battle, current, opponent);
    });
  }

  Future<BattleState> move(
    Session session,
    UuidValue ownerId,
    int battleId,
    BattleMove move,
  ) async {
    return session.db.transaction((transaction) async {
      final battle = await Battle.db.findById(
        session,
        battleId,
        transaction: transaction,
      );
      if (battle == null || battle.ownerId != ownerId) {
        throw notFoundError('Battle');
      }
      if (battle.status != BattleStatus.ongoing) {
        throw conflictError('BATTLE_OVER', 'This battle is already over.');
      }
      if (move == BattleMove.special && battle.specialCooldown > 0) {
        throw invalidInputError('Special is still recharging.');
      }

      final opponent = findOpponent(battle.opponentKey)!;
      final pet = await pets.requireMine(
        session,
        ownerId,
        transaction: transaction,
      );

      var next = _resolveRound(battle, opponent, move);

      final opponentDown = next.opponentHp <= 0;
      final petDown = next.petHp <= 0;
      final outOfRounds = next.round >= maxRounds;
      if (opponentDown || petDown || outOfRounds) {
        // On a double knockout or timeout, the side with more HP left wins
        final won = opponentDown != petDown
            ? opponentDown
            : petWinsTie(
                next.petHp,
                next.petMaxHp,
                next.opponentHp,
                next.opponentMaxHp,
              );
        final (finished, updatedPet) = await _finish(
          session,
          next,
          pet,
          won: won,
          transaction: transaction,
        );
        return _state(finished, updatedPet, opponent);
      }

      next = await Battle.db.updateRow(session, next, transaction: transaction);
      return _state(next, pet, opponent);
    });
  }

  // Both sides act at once. The opponent's move was decided last round (its
  // tell is what the player saw); after resolving, the next one is planned.
  Battle _resolveRound(Battle b, OpponentData o, BattleMove playerMove) {
    final opponentMove =
        b.opponentNextMove ??
        pickOpponentMove(
          hp: b.opponentHp,
          maxHp: b.opponentMaxHp,
          specialCooldown: b.opponentSpecialCooldown,
          rng: _rng,
        );

    final outcome = resolveRound(
      petMove: playerMove,
      opponentMove: opponentMove,
      pet: Fighter(
        maxHp: b.petMaxHp,
        attack: b.petAttack,
        defense: b.petDefense,
      ),
      opponent: o.fighter,
      rng: _rng,
    );

    final round = b.round + 1;
    final opponentHp =
        (b.opponentHp - outcome.damageToOpponent + outcome.opponentHeal).clamp(
          0,
          b.opponentMaxHp,
        );
    final opponentCooldown = opponentMove == BattleMove.special
        ? specialCooldownRounds
        : max(0, b.opponentSpecialCooldown - 1);
    final (nextMove, nextTell) = _planOpponentMove(
      o,
      hp: opponentHp,
      specialCooldown: opponentCooldown,
    );

    return b.copyWith(
      round: round,
      petHp: (b.petHp - outcome.damageToPet + outcome.petHeal).clamp(
        0,
        b.petMaxHp,
      ),
      opponentHp: opponentHp,
      specialCooldown: playerMove == BattleMove.special
          ? specialCooldownRounds
          : max(0, b.specialCooldown - 1),
      opponentSpecialCooldown: opponentCooldown,
      opponentNextMove: nextMove,
      opponentTell: nextTell,
      lastRound: BattleRound(
        round: round,
        playerMove: playerMove,
        opponentMove: opponentMove,
        damageDealt: outcome.damageToOpponent,
        damageTaken: outcome.damageToPet,
        playerCritical: outcome.petCritical,
        opponentCritical: outcome.opponentCritical,
        clash: outcome.clash,
        message: _describe(o.name, playerMove, opponentMove, outcome),
      ),
    );
  }

  (BattleMove, BattleMove) _planOpponentMove(
    OpponentData o, {
    required int hp,
    required int specialCooldown,
  }) {
    final move = pickOpponentMove(
      hp: hp,
      maxHp: o.hp,
      specialCooldown: specialCooldown,
      rng: _rng,
    );
    final tell = tellFor(
      move: move,
      reliability: o.tellReliability,
      specialCooldown: specialCooldown,
      rng: _rng,
    );
    return (move, tell);
  }

  String _describe(
    String opponentName,
    BattleMove player,
    BattleMove opponent,
    RoundOutcome o,
  ) {
    final crit = o.petCritical ? ' Critical hit!' : '';
    final theirCrit = o.opponentCritical ? ' Critical hit!' : '';
    return switch ((player, opponent)) {
      (BattleMove.attack, BattleMove.attack) =>
        'You trade blows: you deal ${o.damageToOpponent},$crit '
            '$opponentName deals ${o.damageToPet}.$theirCrit',
      (BattleMove.special, BattleMove.special) =>
        'Specials collide! You deal ${o.damageToOpponent},$crit '
            '$opponentName deals ${o.damageToPet}.$theirCrit',
      (BattleMove.defend, BattleMove.defend) =>
        'You both hold back and catch your breath.',
      (BattleMove.attack, BattleMove.special) =>
        'You strike before $opponentName\'s special lands: '
            '${o.damageToOpponent} damage.$crit',
      (BattleMove.special, BattleMove.attack) =>
        '$opponentName interrupts your special: '
            '${o.damageToPet} damage.$theirCrit',
      (BattleMove.special, BattleMove.defend) =>
        'Your special smashes through $opponentName\'s guard: '
            '${o.damageToOpponent} damage!$crit',
      (BattleMove.defend, BattleMove.special) =>
        '$opponentName\'s special smashes through your guard: '
            '${o.damageToPet} damage.$theirCrit',
      (BattleMove.defend, BattleMove.attack) =>
        'You block and counter for ${o.damageToOpponent}!$crit '
            'Only ${o.damageToPet} gets through.',
      (BattleMove.attack, BattleMove.defend) =>
        '$opponentName blocks and counters for ${o.damageToPet}.$theirCrit '
            'Only ${o.damageToOpponent} gets through.',
    };
  }

  // Ends the battle, pays out rewards and saves both rows
  Future<(Battle, Pet)> _finish(
    Session session,
    Battle battle,
    Pet pet, {
    required bool won,
    required Transaction transaction,
  }) async {
    final opponent = findOpponent(battle.opponentKey)!;
    final coins = won ? opponent.coinReward : 0;
    final xp = won ? 20 + opponent.level * 5 : 5;
    final energyChange = won ? stats.battleWinEnergy : -stats.battleEnergyCost;

    final rewarded = pet.copyWith(
      coins: pet.coins + coins,
      energy: stats.clampStat(pet.energy + energyChange),
      wins: pet.wins + (won ? 1 : 0),
      losses: pet.losses + (won ? 0 : 1),
    );
    final (leveled, _) = stats.addXp(rewarded, xp);
    final savedPet = await Pet.db.updateRow(
      session,
      leveled,
      transaction: transaction,
    );

    final savedBattle = await Battle.db.updateRow(
      session,
      battle.copyWith(
        status: won ? BattleStatus.won : BattleStatus.lost,
        coinsEarned: coins,
        xpEarned: xp,
        energyChange: savedPet.energy - pet.energy,
      ),
      transaction: transaction,
    );
    return (savedBattle, savedPet);
  }

  int _winChance(Fighter pet, OpponentData o) => simulateWinChance(
    pet,
    o.fighter,
    tellReliability: o.tellReliability,
    seed: _matchupSeed(pet, o),
  );

  // Same matchup, same number, so the % doesn't jump around between visits
  static int _matchupSeed(Fighter pet, OpponentData o) {
    var seed = pet.maxHp * 1000003 + pet.attack * 10007 + pet.defense * 101;
    for (final unit in o.key.codeUnits) {
      seed = (seed * 31 + unit) & 0x7fffffff;
    }
    return seed;
  }

  BattleState _state(Battle battle, Pet pet, OpponentData opponent) =>
      BattleState(
        battle: battle,
        opponent: opponent.toProtocol(
          winChance: _winChance(
            Fighter(
              maxHp: battle.petMaxHp,
              attack: battle.petAttack,
              defense: battle.petDefense,
            ),
            opponent,
          ),
        ),
        petName: pet.name,
        petSpeciesKey: pet.speciesKey,
      );
}

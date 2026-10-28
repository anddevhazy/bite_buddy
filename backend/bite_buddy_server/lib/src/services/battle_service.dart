import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/catalog.dart';
import '../utils/pet_stats.dart' as stats;
import 'friend_service.dart';
import 'pet_service.dart';

class BattleService {
  final PetService pets;
  final FriendService friends;
  final Random _rng;

  BattleService({required this.pets, required this.friends, Random? rng})
    : _rng = rng ?? Random();

  static const int specialCooldownRounds = 3;
  static const int maxRounds = 30;
  // Opponent keys for friends' pets are 'friend:<petId>'
  static const String friendKeyPrefix = 'friend:';
  static const String friendDifficulty = 'Friend';

  // The arena opponents, then each friend's pet
  Future<List<Opponent>> opponentsFor(
    Session session,
    UuidValue ownerId,
  ) async {
    final pet = await pets.requireMine(session, ownerId);
    final friendPets = await friends.friendPets(session, ownerId);
    friendPets.sort((a, b) => a.level.compareTo(b.level));
    return [
      for (final o in [...opponents, ...friendPets.map(_friendOpponent)])
        o.toProtocol(winChance: _winChance(pet, o)),
    ];
  }

  Future<BattleState> start(
    Session session,
    UuidValue ownerId,
    String opponentKey,
  ) async {
    return session.db.transaction((transaction) async {
      final opponent = await _findOpponent(
        session,
        ownerId,
        opponentKey,
        transaction: transaction,
      );
      if (opponent == null) throw notFoundError('Opponent');

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
          opponent: null,
          transaction: transaction,
        );
        current = forfeited.$2;
      }

      final maxHp = stats.petMaxHp(current);
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

      // A friend's pet is read again each round, so it fights with whatever
      // stats it has now. If the friendship ended mid-battle, it's gone.
      final opponent = await _findOpponent(
        session,
        ownerId,
        battle.opponentKey,
        transaction: transaction,
      );
      if (opponent == null) throw notFoundError('Opponent');
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
        final won =
            (opponentDown && !petDown) ||
            (!opponentDown &&
                !petDown &&
                next.petHp / next.petMaxHp >=
                    next.opponentHp / next.opponentMaxHp) ||
            (opponentDown && petDown && next.petHp >= next.opponentHp);
        final (finished, updatedPet) = await _finish(
          session,
          next,
          pet,
          won: won,
          opponent: opponent,
          transaction: transaction,
        );
        return _state(finished, updatedPet, opponent);
      }

      next = await Battle.db.updateRow(session, next, transaction: transaction);
      return _state(next, pet, opponent);
    });
  }

  // Both sides act at once: damage, defence and healing are applied together
  Battle _resolveRound(Battle b, OpponentData o, BattleMove playerMove) {
    final opponentMove = _pickOpponentMove(b);

    var dealt = stats.baseDamage(b.petAttack, o.defense, _rng);
    var taken = stats.baseDamage(o.attack, b.petDefense, _rng);

    // Special hits harder. Defending means not attacking this round, and
    // taking half damage.
    if (playerMove == BattleMove.special) dealt = (dealt * 1.6).round();
    if (opponentMove == BattleMove.special) taken = (taken * 1.6).round();
    if (playerMove == BattleMove.defend) dealt = 0;
    if (opponentMove == BattleMove.defend) taken = 0;
    if (playerMove == BattleMove.defend) taken = (taken / 2).round();
    if (opponentMove == BattleMove.defend) dealt = (dealt / 2).round();

    final petHeal = playerMove == BattleMove.defend
        ? (b.petMaxHp * 0.05).round()
        : 0;
    final oppHeal = opponentMove == BattleMove.defend
        ? (b.opponentMaxHp * 0.05).round()
        : 0;

    final round = b.round + 1;
    return b.copyWith(
      round: round,
      petHp: (b.petHp - taken + petHeal).clamp(0, b.petMaxHp),
      opponentHp: (b.opponentHp - dealt + oppHeal).clamp(0, b.opponentMaxHp),
      specialCooldown: playerMove == BattleMove.special
          ? specialCooldownRounds
          : max(0, b.specialCooldown - 1),
      opponentSpecialCooldown: opponentMove == BattleMove.special
          ? specialCooldownRounds
          : max(0, b.opponentSpecialCooldown - 1),
      lastRound: BattleRound(
        round: round,
        playerMove: playerMove,
        opponentMove: opponentMove,
        damageDealt: dealt,
        damageTaken: taken,
        message: _describe(o.name, playerMove, opponentMove, dealt, taken),
      ),
    );
  }

  // Opponents fight like a player would: they lean on Special when it's ready
  // and turtle up when they're low on HP.
  BattleMove _pickOpponentMove(Battle b) {
    final lowHp = b.opponentHp < b.opponentMaxHp * 0.35;
    final specialReady = b.opponentSpecialCooldown == 0;
    final roll = _rng.nextDouble();

    if (specialReady && roll < (lowHp ? 0.45 : 0.25)) return BattleMove.special;
    if (roll < (lowHp ? 0.75 : 0.45)) return BattleMove.defend;
    return BattleMove.attack;
  }

  String _describe(
    String opponentName,
    BattleMove player,
    BattleMove opponent,
    int dealt,
    int taken,
  ) {
    final yours = switch (player) {
      BattleMove.attack => 'You attack for $dealt',
      BattleMove.special => 'Special hit! $dealt damage',
      BattleMove.defend => 'You brace yourself',
    };
    final theirs = switch (opponent) {
      BattleMove.attack => '$opponentName strikes for $taken',
      BattleMove.special => '$opponentName unleashes a special for $taken',
      BattleMove.defend => '$opponentName blocks',
    };
    return '$yours. $theirs.';
  }

  // Ends the battle, pays out rewards and saves both rows. [opponent] is only
  // needed for a win.
  Future<(Battle, Pet)> _finish(
    Session session,
    Battle battle,
    Pet pet, {
    required bool won,
    required OpponentData? opponent,
    required Transaction transaction,
  }) async {
    final coins = won
        ? await _coinsFor(session, battle, opponent!, transaction)
        : 0;
    final xp = won ? 20 + opponent!.level * 5 : 5;
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

  // Friend wins only pay the first time each day
  Future<int> _coinsFor(
    Session session,
    Battle battle,
    OpponentData opponent,
    Transaction transaction,
  ) async {
    if (!battle.opponentKey.startsWith(friendKeyPrefix)) {
      return opponent.coinReward;
    }
    final paidToday = await Battle.db.count(
      session,
      where: (t) =>
          t.ownerId.equals(battle.ownerId) &
          t.opponentKey.equals(battle.opponentKey) &
          t.status.equals(BattleStatus.won) &
          (t.coinsEarned > 0) &
          (t.createdAt > DateTime.now().toUtc().subtract(const Duration(days: 1))),
      transaction: transaction,
    );
    return paidToday > 0 ? 0 : opponent.coinReward;
  }

  Future<OpponentData?> _findOpponent(
    Session session,
    UuidValue ownerId,
    String key, {
    Transaction? transaction,
  }) async {
    if (!key.startsWith(friendKeyPrefix)) return findOpponent(key);

    final petId = int.tryParse(key.substring(friendKeyPrefix.length));
    if (petId == null) return null;
    final pet = await Pet.db.findById(session, petId, transaction: transaction);
    if (pet == null ||
        !await friends.areFriends(
          session,
          ownerId,
          pet.ownerId,
          transaction: transaction,
        )) {
      return null;
    }
    return _friendOpponent(pet);
  }

  // A friend's pet fights with the same stats it would have as a player
  OpponentData _friendOpponent(Pet pet) => OpponentData(
    '$friendKeyPrefix${pet.id}',
    pet.name,
    findSpecies(pet.speciesKey)?.emoji ?? '🐾',
    pet.level,
    stats.petMaxHp(pet),
    stats.petAttack(pet),
    stats.petDefense(pet),
    friendDifficulty,
    stats.friendCoinReward(pet),
  );

  int _winChance(Pet pet, OpponentData o) => stats.winChance(
    petHp: stats.petMaxHp(pet),
    petAtk: stats.petAttack(pet),
    petDef: stats.petDefense(pet),
    oppHp: o.hp,
    oppAtk: o.attack,
    oppDef: o.defense,
  );

  BattleState _state(Battle battle, Pet pet, OpponentData opponent) =>
      BattleState(
        battle: battle,
        opponent: opponent.toProtocol(winChance: _winChance(pet, opponent)),
        petName: pet.name,
        petSpeciesKey: pet.speciesKey,
      );
}

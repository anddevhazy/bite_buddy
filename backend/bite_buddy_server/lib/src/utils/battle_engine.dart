import 'dart:math';

import '../generated/protocol.dart';

// The battle rules, with no database, so real battles and the win-chance
// simulation run exactly the same code.
//
// Each move beats one other and loses to the third:
//   Attack beats Special  (interrupts the wind-up; the special fizzles)
//   Special beats Defend  (breaks the guard for heavy damage)
//   Defend beats Attack   (blocks most of the hit and counters)
// The opponent picks its move a round ahead and shows a tell, which is true
// [OpponentData.tellReliability] of the time. Reading tells wins fights.
//
// The numbers were tuned by simulating thousands of battles; change them
// together and re-check the spread of win chances.

const int maxRounds = 30;
const int specialCooldownRounds = 2;

const double _damageScale = 1.6;
const double _variance = 0.25; // each hit lands between 75% and 125%
const double _critChance = 0.15;
const double _critMultiplier = 1.75;
const double _specialMultiplier = 1.6; // special against special
const double _interruptMultiplier = 1.25; // attack against special
const double _guardBreakMultiplier = 1.8; // special against defend
const double _blockedMultiplier = 0.25; // attack into defend
const double _counterMultiplier = 0.9; // defend's counter-hit
const double _defendHeal = 0.05; // both defend: each heals 5% of max HP

class Fighter {
  final int maxHp;
  final int attack;
  final int defense;

  const Fighter({
    required this.maxHp,
    required this.attack,
    required this.defense,
  });
}

class Hit {
  final int damage;
  final bool critical;

  const Hit(this.damage, this.critical);
}

class RoundOutcome {
  final int damageToOpponent;
  final int damageToPet;
  final int petHeal;
  final int opponentHeal;
  final bool petCritical;
  final bool opponentCritical;
  final String clash;

  const RoundOutcome({
    required this.damageToOpponent,
    required this.damageToPet,
    required this.petHeal,
    required this.opponentHeal,
    required this.petCritical,
    required this.opponentCritical,
    required this.clash,
  });
}

Hit rollHit(int attack, int defense, Random rng) {
  final roll = 1 - _variance + rng.nextDouble() * 2 * _variance;
  var damage = (attack * roll - defense * 0.5) * _damageScale;
  final critical = rng.nextDouble() < _critChance;
  if (critical) damage *= _critMultiplier;
  return Hit(max(1, damage.round()), critical);
}

RoundOutcome resolveRound({
  required BattleMove petMove,
  required BattleMove opponentMove,
  required Fighter pet,
  required Fighter opponent,
  required Random rng,
}) {
  final petHit = rollHit(pet.attack, opponent.defense, rng);
  final oppHit = rollHit(opponent.attack, pet.defense, rng);
  int scaled(Hit h, double x) => max(1, (h.damage * x).round());

  var toOpp = 0, toPet = 0, petHeal = 0, oppHeal = 0;
  var clash = '';
  var petLanded = false, oppLanded = false;

  switch ((petMove, opponentMove)) {
    case (BattleMove.attack, BattleMove.attack):
      (toOpp, toPet) = (petHit.damage, oppHit.damage);
      (petLanded, oppLanded) = (true, true);
    case (BattleMove.special, BattleMove.special):
      toOpp = scaled(petHit, _specialMultiplier);
      toPet = scaled(oppHit, _specialMultiplier);
      (petLanded, oppLanded) = (true, true);
    case (BattleMove.defend, BattleMove.defend):
      petHeal = (pet.maxHp * _defendHeal).round();
      oppHeal = (opponent.maxHp * _defendHeal).round();
      clash = 'Standoff';
    case (BattleMove.attack, BattleMove.special):
      toOpp = scaled(petHit, _interruptMultiplier);
      petLanded = true;
      clash = 'Interrupted!';
    case (BattleMove.special, BattleMove.attack):
      toPet = scaled(oppHit, _interruptMultiplier);
      oppLanded = true;
      clash = 'Interrupted!';
    case (BattleMove.special, BattleMove.defend):
      toOpp = scaled(petHit, _guardBreakMultiplier);
      petLanded = true;
      clash = 'Guard broken!';
    case (BattleMove.defend, BattleMove.special):
      toPet = scaled(oppHit, _guardBreakMultiplier);
      oppLanded = true;
      clash = 'Guard broken!';
    case (BattleMove.defend, BattleMove.attack):
      toOpp = scaled(petHit, _counterMultiplier);
      toPet = scaled(oppHit, _blockedMultiplier);
      (petLanded, oppLanded) = (true, true);
      clash = 'Blocked & countered!';
    case (BattleMove.attack, BattleMove.defend):
      toOpp = scaled(petHit, _blockedMultiplier);
      toPet = scaled(oppHit, _counterMultiplier);
      (petLanded, oppLanded) = (true, true);
      clash = 'Blocked & countered!';
  }

  return RoundOutcome(
    damageToOpponent: toOpp,
    damageToPet: toPet,
    petHeal: petHeal,
    opponentHeal: oppHeal,
    petCritical: petLanded && petHit.critical,
    opponentCritical: oppLanded && oppHit.critical,
    clash: clash,
  );
}

// The opponent fights like a player would: more Defend when hurt, Special
// whenever it's ready
BattleMove pickOpponentMove({
  required int hp,
  required int maxHp,
  required int specialCooldown,
  required Random rng,
}) {
  final hurt = hp < maxHp * 0.35;
  final weights = {
    BattleMove.attack: 0.40,
    BattleMove.defend: hurt ? 0.45 : 0.30,
    BattleMove.special: specialCooldown > 0 ? 0.0 : (hurt ? 0.35 : 0.30),
  };
  var roll = rng.nextDouble() * weights.values.reduce((a, b) => a + b);
  for (final entry in weights.entries) {
    roll -= entry.value;
    if (roll < 0) return entry.key;
  }
  return BattleMove.attack;
}

// What the opponent appears to be about to do: the truth [reliability]
// percent of the time, otherwise a bluff (another move it could make)
BattleMove tellFor({
  required BattleMove move,
  required int reliability,
  required int specialCooldown,
  required Random rng,
}) {
  if (rng.nextInt(100) < reliability) return move;
  final bluffs = [
    for (final m in BattleMove.values)
      if (m != move && !(m == BattleMove.special && specialCooldown > 0)) m,
  ];
  return bluffs.isEmpty ? move : bluffs[rng.nextInt(bluffs.length)];
}

// Who wins when a battle ends with both down, or after [maxRounds]
bool petWinsTie(int petHp, int petMaxHp, int oppHp, int oppMaxHp) =>
    petHp / petMaxHp >= oppHp / oppMaxHp;

// The move that beats [tell]; what a player who reads tells would pick
BattleMove counterTo(BattleMove tell, {required int specialCooldown}) =>
    switch (tell) {
      BattleMove.attack => BattleMove.defend,
      BattleMove.special => BattleMove.attack,
      BattleMove.defend =>
        specialCooldown == 0 ? BattleMove.special : BattleMove.defend,
    };

// Chance (0-100) that [pet] beats the opponent, found by playing [fights]
// battles with a player who always counters the tell. Seeded from the
// matchup, so the same matchup always shows the same number.
int simulateWinChance(
  Fighter pet,
  Fighter opponent, {
  required int tellReliability,
  required int seed,
  int fights = 400,
}) {
  final rng = Random(seed);
  var wins = 0;
  for (var i = 0; i < fights; i++) {
    var petHp = pet.maxHp, oppHp = opponent.maxHp;
    var petCd = 0, oppCd = 0;
    bool? won;
    for (var round = 0; round < maxRounds && won == null; round++) {
      final oppMove = pickOpponentMove(
        hp: oppHp,
        maxHp: opponent.maxHp,
        specialCooldown: oppCd,
        rng: rng,
      );
      final tell = tellFor(
        move: oppMove,
        reliability: tellReliability,
        specialCooldown: oppCd,
        rng: rng,
      );
      final petMove = counterTo(tell, specialCooldown: petCd);
      final o = resolveRound(
        petMove: petMove,
        opponentMove: oppMove,
        pet: pet,
        opponent: opponent,
        rng: rng,
      );
      petHp = (petHp - o.damageToPet + o.petHeal).clamp(0, pet.maxHp);
      oppHp = (oppHp - o.damageToOpponent + o.opponentHeal).clamp(
        0,
        opponent.maxHp,
      );
      petCd = petMove == BattleMove.special
          ? specialCooldownRounds
          : max(0, petCd - 1);
      oppCd = oppMove == BattleMove.special
          ? specialCooldownRounds
          : max(0, oppCd - 1);
      if (petHp == 0 || oppHp == 0) {
        won = oppHp == 0 && petHp > 0
            ? true
            : petHp == 0 && oppHp > 0
            ? false
            : petWinsTie(petHp, pet.maxHp, oppHp, opponent.maxHp);
      }
    }
    won ??= petWinsTie(petHp, pet.maxHp, oppHp, opponent.maxHp);
    if (won) wins++;
  }
  return (wins * 100 / fights).round();
}

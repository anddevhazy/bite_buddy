import 'dart:math';

import '../generated/protocol.dart';

// The battle rules, with no database, so real battles and the win-chance
// simulation run exactly the same code.
//
// Each move beats one other and loses to the third:
//   Attack beats Special  (interrupts the wind-up; the special fizzles)
//   Special beats Defend  (breaks the guard for heavy damage)
//   Defend beats Attack   (blocks most of the hit and counters)
// Used for friend duels; the real-time arena shares the hit numbers below.
//
// The numbers were tuned by simulating thousands of battles; change them
// together and re-check the spread of win chances.

const int maxRounds = 30;
const int specialCooldownRounds = 2;

const double damageScale = 1.6;
const double variance = 0.25; // each hit lands between 75% and 125%
const double critChance = 0.15;
const double critMultiplier = 1.75;
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
  final roll = 1 - variance + rng.nextDouble() * 2 * variance;
  var damage = (attack * roll - defense * 0.5) * damageScale;
  final critical = rng.nextDouble() < critChance;
  if (critical) damage *= critMultiplier;
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

// Who wins when a battle ends with both down, or after [maxRounds]
bool petWinsTie(int petHp, int petMaxHp, int oppHp, int oppMaxHp) =>
    petHp / petMaxHp >= oppHp / oppMaxHp;

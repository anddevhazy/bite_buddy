import 'dart:math';

import '../generated/protocol.dart';
import 'battle_engine.dart' as engine;

// The real-time arena's numbers. Sent to the phone with every fight so they
// live in one place; hits use the same base formula as friend duels.
// Tuned by simulating fights with human-like reaction times; adjust after
// real play. The phone uses whatever the server sends, so changes here apply
// without an app update.
ArenaRules arenaRules() => ArenaRules(
  hpMultiplier: 5,
  // High enough that mashing Attack loses even to the Wild Pup (see the
  // app's test/features/battle/balance_test.dart)
  opponentPower: 7.0,
  damageScale: engine.damageScale,
  variance: engine.variance,
  critChance: engine.critChance,
  critMultiplier: engine.critMultiplier,
  counterMultiplier: 1.25,
  specialMultiplier: 2.5,
  blockedMultiplier: 0.25,
  perfectBlockMs: 150,
  stunMs: 1000,
  attackCooldownMs: 550,
  dodgeCooldownMs: 700,
  dodgeMs: 300,
  specialMeterMax: 100,
  meterPerCounter: 15,
  meterPerParry: 30,
  meterPerDodge: 20,
);

// A fight can't last longer than this; an abandoned one is a loss
const Duration maxRunLength = Duration(minutes: 15);
// Allowance for the phone's clock and network delays
const int clockSlackMs = 3000;

// The biggest single hit [attack] can land on [defense] (a critical counter)
double maxHitDamage(int attack, int defense, ArenaRules r) =>
    max(1, attack * (1 + r.variance) - defense * 0.5) *
    r.damageScale *
    r.critMultiplier *
    r.counterMultiplier;

// Whether a reported win could really have happened. It can't prove a win
// was played fairly (the fight runs on the phone), but it rejects the
// impossible: too fast, too little damage, or the pet should have fainted.
bool winIsPlausible({
  required ArenaRunReport report,
  required int serverElapsedMs,
  required engine.Fighter pet,
  required engine.Fighter opponent,
  required ArenaRules rules,
}) {
  final petHp = pet.maxHp * rules.hpMultiplier;
  final opponentHp = opponent.maxHp * rules.hpMultiplier;
  if (report.durationMs > serverElapsedMs + clockSlackMs) return false;
  if (report.damageDealt < opponentHp) return false;
  if (report.damageTaken >= petHp) return false;

  // Even landing a critical counter on every attack cooldown, knocking the
  // opponent out takes at least this long (halved to allow for Specials)
  final bestDps =
      maxHitDamage(pet.attack, opponent.defense, rules) /
      (rules.attackCooldownMs / 1000);
  final fastestMs = opponentHp / bestDps * 1000 * 0.5;
  return report.durationMs >= fastestMs;
}

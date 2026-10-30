import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:flutter_test/flutter_test.dart';

// The same numbers the server sends (backend utils/arena_rules.dart)
const rules = ArenaRulesEntity(
  hpMultiplier: 5,
  opponentPower: 2.0,
  damageScale: 1.6,
  variance: 0.25,
  critChance: 0.15,
  critMultiplier: 1.75,
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

OpponentEntity opponent({
  int heavyChance = 0,
  int feintChance = 0,
  int comboChance = 0,
  int blockChance = 0,
  int windupMs = 600,
  int hp = 80,
  int attack = 18,
  int defense = 10,
}) => OpponentEntity(
  key: 'test',
  name: 'Test',
  emoji: '',
  level: 1,
  hp: hp,
  attack: attack,
  defense: defense,
  difficulty: 'Easy',
  coinReward: 75,
  windupMs: windupMs,
  recoveryMs: 800,
  attackIntervalMs: 1500,
  heavyChance: heavyChance,
  feintChance: feintChance,
  comboChance: comboChance,
  blockChance: blockChance,
);

FightEngine engine(OpponentEntity o, {int seed = 1}) => FightEngine(
  ArenaRunConfigEntity(
    runId: 1,
    petName: 'Hazy',
    petSpeciesKey: 'thunder',
    petStats: const BattleStatsEntity(hp: 115, attack: 27, defense: 21),
    opponent: o,
    rules: rules,
    seed: seed,
  ),
);

// Advances the engine in 10ms frames until [until] is true
List<FightEvent> runUntil(FightEngine e, bool Function() until) {
  final events = <FightEvent>[];
  for (var i = 0; i < 20000 && !until(); i++) {
    e.update(10);
    events.addAll(e.takeEvents());
  }
  return events;
}

void main() {
  test('HP is multiplied for the arena', () {
    final e = engine(opponent());
    expect(e.petMaxHp, 115 * 5);
    expect(e.opponentMaxHp, 80 * 5);
  });

  test('getting hit by a jab costs HP', () {
    final e = engine(opponent());
    runUntil(e, () => e.phase == OpponentPhase.recovering);
    expect(e.petHp, lessThan(e.petMaxHp));
    expect(e.damageTaken, e.petMaxHp - e.petHp);
  });

  test('a block started at the last moment parries: no damage, stun', () {
    final e = engine(opponent());
    runUntil(e, () => e.phase == OpponentPhase.windup);
    // Wait until just before the hit, then block
    runUntil(e, () => e.windupProgress > 0.9);
    e.startBlock();
    final events = runUntil(e, () => e.phase != OpponentPhase.windup);
    final strike = events.whereType<OpponentStruck>().single;
    expect(strike.result, StrikeResult.parried);
    expect(e.petHp, e.petMaxHp);
    expect(e.phase, OpponentPhase.stunned);
    expect(e.meter, rules.meterPerParry);
  });

  test('an early block only reduces the damage', () {
    final e = engine(opponent());
    e.startBlock();
    final events = runUntil(e, () => e.phase == OpponentPhase.recovering);
    final strike = events.whereType<OpponentStruck>().single;
    expect(strike.result, StrikeResult.blocked);
    expect(strike.damage, greaterThan(0));
  });

  test("heavy attacks can't be blocked, but dodging one stuns", () {
    final blocked = engine(opponent(heavyChance: 100));
    blocked.startBlock();
    final events = runUntil(
      blocked,
      () => blocked.phase == OpponentPhase.recovering,
    );
    expect(
      events.whereType<OpponentStruck>().single.result,
      StrikeResult.guardBroken,
    );

    final dodged = engine(opponent(heavyChance: 100));
    runUntil(dodged, () => dodged.windupProgress > 0.8);
    dodged.dodge();
    final dodgeEvents = runUntil(
      dodged,
      () => dodged.phase != OpponentPhase.windup,
    );
    expect(
      dodgeEvents.whereType<OpponentStruck>().single.result,
      StrikeResult.dodged,
    );
    expect(dodged.phase, OpponentPhase.stunned);
    expect(dodged.petHp, dodged.petMaxHp);
  });

  test('attacking while the opponent is open is a stronger counter', () {
    final e = engine(opponent());
    runUntil(e, () => e.phase == OpponentPhase.recovering);
    e.attack();
    final hit = e.takeEvents().whereType<PlayerHit>().single;
    expect(hit.kind, PlayerHitKind.counter);
    expect(e.meter, rules.meterPerCounter);
  });

  test('attacks have a cooldown', () {
    final e = engine(opponent());
    e.attack();
    e.attack();
    expect(e.takeEvents().whereType<PlayerHit>(), hasLength(1));
    e.update(rules.attackCooldownMs);
    e.attack();
    expect(e.takeEvents().whereType<PlayerHit>(), hasLength(1));
  });

  test('a full meter unlocks the Special, which empties it', () {
    final e = engine(opponent());
    e.meter = rules.specialMeterMax;
    expect(e.specialReady, isTrue);
    e.special();
    final hit = e.takeEvents().whereType<PlayerHit>().single;
    expect(hit.kind, PlayerHitKind.special);
    expect(e.meter, 0);
  });

  test('feints wind up but never strike', () {
    final e = engine(opponent(feintChance: 100));
    final events = runUntil(e, () => e.timeMs > 5000);
    expect(events.whereType<FeintRevealed>(), isNotEmpty);
    expect(events.whereType<OpponentStruck>(), isEmpty);
  });

  test('a combo follows a jab too fast to dodge twice, but a block holds', () {
    // Dodge the first jab: the follow-up comes before dodge is ready again
    final dodger = engine(opponent(comboChance: 100));
    runUntil(dodger, () => dodger.windupProgress > 0.8);
    dodger.dodge();
    final dodgerStrikes = runUntil(
      dodger,
      () => dodger.phase == OpponentPhase.recovering,
    ).whereType<OpponentStruck>().toList();
    expect(dodgerStrikes.map((s) => s.result), [
      StrikeResult.dodged,
      StrikeResult.hit,
    ]);

    // Hold block: both jabs land on it
    final blocker = engine(opponent(comboChance: 100));
    blocker.startBlock();
    final blockerStrikes = runUntil(
      blocker,
      () => blocker.phase == OpponentPhase.recovering,
    ).whereType<OpponentStruck>().toList();
    expect(blockerStrikes.map((s) => s.result), [
      StrikeResult.blocked,
      StrikeResult.blocked,
    ]);
  });

  test('the same seed plays out the same fight', () {
    final a = engine(opponent(heavyChance: 30, feintChance: 20), seed: 9);
    final b = engine(opponent(heavyChance: 30, feintChance: 20), seed: 9);
    runUntil(a, () => a.timeMs > 20000);
    runUntil(b, () => b.timeMs > 20000);
    expect(a.petHp, b.petHp);
  });

  group('whole fights', () {
    // A player who reacts well: dodges heavies, parries jabs, counters
    void playWell(FightEngine e) {
      if (e.phase == OpponentPhase.windup && e.windupProgress > 0.85) {
        if (e.windupKind == AttackKind.heavy) {
          e.dodge();
        } else {
          e.startBlock();
        }
      } else if (e.phase != OpponentPhase.windup) {
        e.endBlock();
      }
      if (e.specialReady) e.special();
      if (e.opponentOpen) e.attack();
    }

    test('good play beats the easiest opponent and reports the win', () {
      final e = engine(opponent(heavyChance: 10, blockChance: 10));
      runUntil(e, () {
        playWell(e);
        return e.isOver;
      });
      expect(e.outcome, FightOutcome.won);
      final report = e.report();
      expect(report.won, isTrue);
      expect(report.damageDealt, greaterThanOrEqualTo(e.opponentMaxHp));
      // Even perfect play against the easiest opponent takes a while
      expect(report.durationMs, greaterThan(5000));
    });

    test('doing nothing loses', () {
      final e = engine(opponent());
      runUntil(e, () => e.isOver);
      expect(e.outcome, FightOutcome.lost);
    });
  });
}

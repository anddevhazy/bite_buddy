import 'dart:math';

import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/presentation/game/fight_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fight_engine_test.dart' show rules;

// Plays many fights with bots against the real opponents (keep in step
// with backend utils/catalog.dart) to check that effort is needed to win: mashing Attack
// must lose, even against the easiest, while careful play wins.

typedef Opp = (String, int, int, int, int, int, int, int, int, int, int, int);

const _opponents = <Opp>[
  // key, level, hp, attack, defense, windup, recovery, interval, heavy, feint, combo, block
  ('wild_pup', 1, 80, 26, 10, 750, 700, 1400, 10, 0, 10, 10),
  ('forest_guardian', 2, 120, 28, 16, 650, 800, 1500, 20, 5, 20, 20),
  ('shadow_beast', 3, 150, 30, 22, 560, 700, 1300, 25, 15, 30, 30),
  ('storm_drake', 5, 200, 38, 30, 480, 600, 1150, 35, 20, 40, 35),
  ('ancient_golem', 8, 280, 46, 42, 420, 550, 1050, 40, 30, 50, 45),
];

OpponentEntity _entity(Opp o) => OpponentEntity(
  key: o.$1,
  name: o.$1,
  emoji: '',
  level: o.$2,
  hp: o.$3,
  attack: o.$4,
  defense: o.$5,
  difficulty: '',
  coinReward: 0,
  windupMs: o.$6,
  recoveryMs: o.$7,
  attackIntervalMs: o.$8,
  heavyChance: o.$9,
  feintChance: o.$10,
  comboChance: o.$11,
  blockChance: o.$12,
);

// A healthy, well-fed pet at the opponent's level (server pet_stats.dart)
BattleStatsEntity _pet(int level) => BattleStatsEntity(
  hp: (60 + 100 * 0.4 + level * 10).round(),
  attack: (10 + level * 4 + 70 / 5).round(),
  defense: (6 + level * 3 + 100 / 10).round(),
);

abstract class _Bot {
  void act(FightEngine e, int nowMs);
}

// Taps Attack as fast as the game allows, nothing else
class _Masher implements _Bot {
  @override
  void act(FightEngine e, int nowMs) => e.attack();
}

// A careful player with human reaction times (~220-380ms) who sometimes
// mistimes: blocks jabs late, dodges heavies, attacks when the opponent is
// open, and doesn't swing into a raised guard
class _Skilled implements _Bot {
  final Random rng;
  _Skilled(this.rng);

  OpponentPhase? _seen;
  int _seenAt = 0;
  int _reaction = 300;

  @override
  void act(FightEngine e, int nowMs) {
    if (e.phase != _seen) {
      _seen = e.phase;
      _seenAt = nowMs;
      _reaction = 220 + rng.nextInt(160);
    }
    final sinceChange = nowMs - _seenAt;
    if (e.phase == OpponentPhase.windup) {
      if (sinceChange < _reaction) return;
      // Acts in the last ~20% of the windup, with some timing error
      final aim = 0.78 + (rng.nextDouble() - 0.5) * 0.2;
      if (e.windupProgress >= aim) {
        e.windupKind == AttackKind.heavy ? e.dodge() : e.startBlock();
      }
      return;
    }
    e.endBlock();
    if (e.specialReady && e.opponentOpen) e.special();
    if (e.opponentOpen && sinceChange >= _reaction) e.attack();
  }
}

double _winRate(Opp o, _Bot Function(Random) bot, {int fights = 100}) {
  var wins = 0;
  for (var seed = 0; seed < fights; seed++) {
    final e = FightEngine(
      ArenaRunConfigEntity(
        runId: seed,
        petName: 'Bot',
        petSpeciesKey: 'fluffy',
        petStats: _pet(o.$2),
        opponent: _entity(o),
        rules: rules,
        seed: seed,
      ),
    );
    final b = bot(Random(seed + 1000));
    var now = 0;
    while (!e.isOver && now < FightEngine.timeLimitMs + 1000) {
      b.act(e, now);
      e.update(16);
      e.takeEvents();
      now += 16;
    }
    if (e.outcome == FightOutcome.won) wins++;
  }
  return wins / fights;
}

void main() {
  for (final o in _opponents) {
    test('${o.$1}: mashing Attack loses, careful play wins', () {
      expect(_winRate(o, (_) => _Masher()), lessThan(0.1));
      // Careful play beats opponents at the pet's level
      if (o.$2 <= 3) expect(_winRate(o, _Skilled.new), greaterThan(0.85));
    });
  }
}

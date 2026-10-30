import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/arena_rules.dart';
import 'package:bite_buddy_server/src/utils/battle_engine.dart';
import 'package:bite_buddy_server/src/utils/catalog.dart';
import 'package:test/test.dart';

void main() {
  const pet = Fighter(maxHp: 115, attack: 27, defense: 21);
  final pup = findOpponent('wild_pup')!.fighter;
  final rules = arenaRules();

  ArenaRunReport report({
    int durationMs = 30000,
    int? damageDealt,
    int damageTaken = 20,
  }) => ArenaRunReport(
    won: true,
    durationMs: durationMs,
    damageDealt: damageDealt ?? pup.maxHp * rules.hpMultiplier,
    damageTaken: damageTaken,
    hitsLanded: 6,
  );

  bool check(ArenaRunReport r, {int serverElapsedMs = 31000}) => winIsPlausible(
    report: r,
    serverElapsedMs: serverElapsedMs,
    pet: pet,
    opponent: pup,
    rules: rules,
  );

  test('a normal win is accepted', () {
    expect(check(report()), isTrue);
  });

  test('a fight longer than the server saw is rejected', () {
    expect(check(report(durationMs: 60000)), isFalse);
  });

  test('a win without enough damage is rejected', () {
    expect(
      check(report(damageDealt: pup.maxHp * rules.hpMultiplier - 1)),
      isFalse,
    );
  });

  test('a win after taking a knockout is rejected', () {
    expect(
      check(report(damageTaken: pet.maxHp * rules.hpMultiplier)),
      isFalse,
    );
  });

  test('a win faster than the best possible damage is rejected', () {
    expect(check(report(durationMs: 10), serverElapsedMs: 5000), isFalse);
  });

  test('tougher opponents wind up faster and fake more', () {
    final styles = opponents.map((o) => o.style).toList();
    for (var i = 1; i < styles.length; i++) {
      expect(styles[i].windupMs, lessThan(styles[i - 1].windupMs));
      expect(
        styles[i].feintChance,
        greaterThanOrEqualTo(styles[i - 1].feintChance),
      );
    }
  });
}

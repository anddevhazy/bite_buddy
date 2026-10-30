import 'dart:math';

import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/battle_engine.dart';
import 'package:bite_buddy_server/src/utils/duel_rules.dart';
import 'package:bite_buddy_server/src/utils/pet_stats.dart';
import 'package:bite_buddy_server/src/utils/season.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final monday = DateTime.utc(2026, 10, 26);

  Meal meal(int score, DateTime at) => Meal(
    ownerId: const Uuid().v4obj(),
    name: 'meal',
    description: '',
    calories: 400,
    proteinPct: 20,
    carbsPct: 20,
    fatsPct: 20,
    vitaminsPct: 20,
    mineralsPct: 20,
    fiberPct: 20,
    healthScore: score,
    grade: 'B',
    imageHash: '',
    fed: true,
    createdAt: at,
  );

  group('season calendar', () {
    test('weeks start on Monday 00:00 UTC', () {
      expect(weekStart(DateTime.utc(2026, 10, 26)), monday);
      expect(weekStart(DateTime.utc(2026, 10, 30, 13)), monday);
      expect(weekStart(DateTime.utc(2026, 11, 1, 23, 59)), monday);
      expect(weekStart(DateTime.utc(2026, 11, 2)), DateTime.utc(2026, 11, 2));
      expect(weekEnd(monday), DateTime.utc(2026, 11, 2));
    });
  });

  group('feeding score', () {
    test('eating well every day beats eating a lot on one day', () {
      final steady = [
        for (var d = 0; d < 7; d++) meal(80, monday.add(Duration(days: d))),
      ];
      final binge = [for (var i = 0; i < 8; i++) meal(80, monday)];
      expect(feedingScore(steady, 0).score, 80);
      expect(feedingScore(binge, 0).score, (80 / 7).round());
    });

    test('junk food scores low however often you eat it', () {
      final junk = [
        for (var d = 0; d < 7; d++) meal(30, monday.add(Duration(days: d))),
      ];
      expect(feedingScore(junk, 0).score, 30);
    });

    test('no meals scores zero', () {
      expect(feedingScore([], 0).score, 0);
    });
  });

  group('battle score', () {
    test('20 points a win, capped at 100', () {
      expect(battleScore(['a']).score, 20);
      expect(
        battleScore(['a', 'a', 'b', 'b', 'c', 'c', 'd']).score,
        100,
      );
    });

    test('only 2 wins against the same friend count', () {
      expect(battleScore(['a', 'a', 'a', 'a']).wins, 2);
    });
  });

  test('the total is 70% feeding and 30% battles', () {
    expect(totalScore(100, 0), 70);
    expect(totalScore(0, 100), 30);
    expect(totalScore(80, 40), 68);
  });

  group('duels', () {
    const a = Fighter(maxHp: 120, attack: 30, defense: 20);
    const b = Fighter(maxHp: 120, attack: 30, defense: 20);

    test('a missed turn lets the other side hit unopposed', () {
      final o = resolveDuelRound(
        aMove: BattleMove.attack,
        bMove: null,
        a: a,
        b: b,
        rng: Random(1),
      );
      expect(o.damageToOpponent, greaterThan(0));
      expect(o.damageToPet, 0);
      expect(o.clash, 'Missed turn!');
    });

    test('if nobody moves, nothing happens', () {
      final o = resolveDuelRound(
        aMove: null,
        bMove: null,
        a: a,
        b: b,
        rng: Random(1),
      );
      expect(o.damageToOpponent + o.damageToPet, 0);
    });
  });

  test('pets without meals still rank, after those who ate', () {
    Pet pet(String name) => newPet(
      ownerId: const Uuid().v4obj(),
      speciesKey: 'fluffy',
      name: name,
      now: monday,
    );
    final table = rankSeason([
      SeasonActivity(
        memberId: 1,
        pet: pet('Idle'),
        fedMeals: const [],
        beatenFriendIds: const [],
      ),
      SeasonActivity(
        memberId: 2,
        pet: pet('Eater'),
        fedMeals: [meal(70, monday)],
        beatenFriendIds: const [],
        isCaller: true,
      ),
    ]);
    expect(table.map((s) => s.petName), ['Eater', 'Idle']);
    expect(table.first.isYou, isTrue);
  });
}

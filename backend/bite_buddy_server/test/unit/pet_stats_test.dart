import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/pet_stats.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final owner = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final t0 = DateTime.utc(2026, 10, 23, 8);

  Pet pet({DateTime? createdAt}) => newPet(
    ownerId: owner,
    speciesKey: 'fluffy',
    name: 'Fluffy',
    now: createdAt ?? t0,
  );

  Meal meal({int score = 80, int calories = 600}) => Meal(
    ownerId: owner,
    name: 'Rice and beans',
    description: '',
    calories: calories,
    proteinPct: 20,
    carbsPct: 40,
    fatsPct: 10,
    vitaminsPct: 10,
    mineralsPct: 10,
    fiberPct: 15,
    healthScore: score,
    grade: gradeFor(score),
    imageHash: 'x',
    fed: false,
    createdAt: t0,
  );

  group('feed', () {
    test('first meal sets nutrition to the meal score', () {
      final result = feed(pet(), meal(score: 80), t0);
      expect(result.pet.nutrition, 80);
      expect(result.nutritionChange, 80);
      expect(result.pet.mealsEaten, 1);
    });

    test('later meals blend 70/30 with the current nutrition', () {
      final first = feed(pet(), meal(score: 80), t0).pet;
      final second = feed(first, meal(score: 30), t0);
      expect(second.pet.nutrition, 65); // 80 * 0.7 + 30 * 0.3
    });

    test('good food heals, junk food hurts, health stays within 0-100', () {
      final hurt = feed(pet(), meal(score: 0), t0);
      expect(hurt.healthChange, -10);
      // A fresh pet is already at 100 health, so it can't go higher
      expect(feed(pet(), meal(score: 100), t0).pet.health, 100);
    });

    test('energy gain is between 2 and 15', () {
      expect(feed(pet(), meal(calories: 0), t0).energyChange, 2);
      expect(feed(pet(), meal(calories: 5000), t0).energyChange, 15);
    });

    test('a healthy meal gives bonus XP', () {
      expect(feed(pet(), meal(score: 70), t0).xpGained, 15);
      expect(feed(pet(), meal(score: 69), t0).xpGained, 10);
    });
  });

  group('addXp', () {
    test('levels up and carries the remainder over', () {
      final (leveled, up) = addXp(pet(), 130);
      expect(up, isTrue);
      expect(leveled.level, 2);
      expect(leveled.xp, 30);
    });

    test('can level up more than once', () {
      final (leveled, _) = addXp(pet(), 100 + 200 + 5);
      expect(leveled.level, 3);
      expect(leveled.xp, 5);
    });
  });

  group('applyDecay', () {
    test('nothing happens within the 8-hour grace period', () {
      final p = pet();
      expect(applyDecay(p, t0.add(const Duration(hours: 8))).health, 100);
    });

    test('charges whole hours after the grace period', () {
      final p = pet();
      final decayed = applyDecay(p, t0.add(const Duration(hours: 11, minutes: 59)));
      expect(decayed.health, 100 - 3 * healthDecayPerHour);
      expect(decayed.lastDecayAt, t0.add(const Duration(hours: 11)));
    });

    test('calling it repeatedly never double-counts time', () {
      var p = pet();
      for (var m = 0; m < 12 * 60; m += 7) {
        p = applyDecay(p, t0.add(Duration(minutes: m)));
      }
      p = applyDecay(p, t0.add(const Duration(hours: 12)));
      final once = applyDecay(pet(), t0.add(const Duration(hours: 12)));
      expect(p.health, once.health);
      expect(p.nutrition, once.nutrition);
    });

    test('feeding resets the hunger clock', () {
      final fed = feed(pet(), meal(), t0.add(const Duration(hours: 10))).pet;
      final later = applyDecay(fed, t0.add(const Duration(hours: 17)));
      expect(later.health, fed.health);
    });
  });

  group('winChance', () {
    test('is clamped to 5-95', () {
      final easy = winChance(
        petHp: 500, petAtk: 100, petDef: 100,
        oppHp: 10, oppAtk: 1, oppDef: 1,
      );
      final hopeless = winChance(
        petHp: 10, petAtk: 1, petDef: 1,
        oppHp: 500, oppAtk: 100, oppDef: 100,
      );
      expect(easy, 95);
      expect(hopeless, 5);
    });

    test('an even match is about 50%', () {
      final even = winChance(
        petHp: 100, petAtk: 20, petDef: 10,
        oppHp: 100, oppAtk: 20, oppDef: 10,
      );
      expect(even, 50);
    });
  });

  test('gradeFor maps scores to A-F', () {
    expect([90, 75, 60, 45, 10].map(gradeFor), ['A', 'B', 'C', 'D', 'F']);
  });
}

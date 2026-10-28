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
      // The first meal also starts a 1-day streak, worth 1 XP
      expect(feed(pet(), meal(score: 70), t0).xpGained, 15 + 1);
      expect(feed(pet(), meal(score: 69), t0).xpGained, 10 + 1);
    });
  });

  group('streaks', () {
    const day = Duration(days: 1);

    test('the first meal starts a 1-day streak', () {
      final result = feed(pet(), meal(), t0);
      expect(result.pet.streak, 1);
      expect(result.pet.bestStreak, 1);
      expect(result.streakExtended, isTrue);
      expect(result.streakBonusXp, 1);
    });

    test('more meals on the same day do not extend it or earn the bonus', () {
      final first = feed(pet(), meal(), t0).pet;
      final second = feed(first, meal(), t0.add(const Duration(hours: 5)));
      expect(second.pet.streak, 1);
      expect(second.streakExtended, isFalse);
      expect(second.streakBonusXp, 0);
    });

    test('eating on consecutive days grows it, and the bonus caps at 10', () {
      var p = pet();
      for (var i = 0; i < 12; i++) {
        p = feed(p, meal(), t0.add(day * i)).pet;
      }
      expect(p.streak, 12);
      expect(feed(p, meal(), t0.add(day * 12)).streakBonusXp, 10);
    });

    test('a missed day resets it, but the best streak is kept', () {
      var p = pet();
      for (var i = 0; i < 3; i++) {
        p = feed(p, meal(), t0.add(day * i)).pet;
      }
      p = feed(p, meal(), t0.add(day * 4)).pet;
      expect(p.streak, 1);
      expect(p.bestStreak, 3);
    });

    test('expireStreak keeps it through the next day, then clears it', () {
      final fed = feed(pet(), meal(), t0).pet;
      expect(expireStreak(fed, t0.add(const Duration(hours: 39))).streak, 1);
      expect(expireStreak(fed, t0.add(const Duration(hours: 40))).streak, 0);
    });

    test("days follow the owner's time zone, not UTC", () {
      // 23:30 UTC on the 23rd is 00:30 on the 24th in Lagos (UTC+1)
      final lateUtc = DateTime.utc(2026, 10, 23, 23, 30);
      final first = feed(pet(), meal(), t0, utcOffsetMinutes: 60).pet;
      final second = feed(first, meal(), lateUtc, utcOffsetMinutes: 60);
      expect(second.streakExtended, isTrue);
      expect(second.pet.streak, 2);

      final sameDayInUtc = feed(pet(), meal(), t0).pet;
      expect(feed(sameDayInUtc, meal(), lateUtc).streakExtended, isFalse);
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

  group('shared streaks', () {
    final day1 = DateTime.utc(2026, 10, 23);
    final day2 = DateTime.utc(2026, 10, 24);
    final day4 = DateTime.utc(2026, 10, 26);
    Friendship friendship() => Friendship(
      requesterId: owner,
      addresseeId: owner,
      accepted: true,
      sharedStreak: 0,
      sharedStreakDay: null,
      createdAt: t0,
    );

    test('grows once per day, on consecutive days', () {
      final first = bumpSharedStreak(friendship(), day1);
      expect(first.sharedStreak, 1);
      expect(bumpSharedStreak(first, day1).sharedStreak, 1);
      expect(bumpSharedStreak(first, day2).sharedStreak, 2);
    });

    test('a missed day starts it again and hides the old count', () {
      final two = bumpSharedStreak(bumpSharedStreak(friendship(), day1), day2);
      expect(currentSharedStreak(two, day2.add(const Duration(days: 1))), 2);
      expect(currentSharedStreak(two, day4), 0);
      expect(bumpSharedStreak(two, day4).sharedStreak, 1);
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

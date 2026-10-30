import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/services/nutrition_ai/gemini_nutrition_ai.dart';
import 'package:bite_buddy_server/src/utils/activity_rules.dart';
import 'package:bite_buddy_server/src/utils/league_challenge.dart';
import 'package:bite_buddy_server/src/utils/meal_ideas.dart';
import 'package:bite_buddy_server/src/utils/shared_streak.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final monday = DateTime.utc(2026, 10, 26);
  final alice = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final bob = UuidValue.fromString('22222222-2222-4222-8222-222222222222');

  group('shared streaks', () {
    final day1 = DateTime.utc(2026, 10, 26);
    final day2 = DateTime.utc(2026, 10, 27);
    final day4 = DateTime.utc(2026, 10, 29);

    StreakBuddy pair({bool accepted = true}) => StreakBuddy(
      aUserId: alice,
      bUserId: bob,
      accepted: accepted,
      streak: 0,
      bestStreak: 0,
      createdAt: day1,
    );

    test('a day only counts once both friends have fed', () {
      final a = recordSharedFeed(pair(), isA: true, day: day1);
      expect(a.extended, isFalse);
      expect(a.buddy.streak, 0);

      final b = recordSharedFeed(a.buddy, isA: false, day: day1);
      expect(b.extended, isTrue);
      expect(b.buddy.streak, 1);
      expect(b.buddy.lastStreakDay, day1);

      // A second meal the same day doesn't count again
      final again = recordSharedFeed(b.buddy, isA: true, day: day1);
      expect(again.extended, isFalse);
      expect(again.buddy.streak, 1);
    });

    test('consecutive days grow the streak, a gap starts it over', () {
      var buddy = pair();
      for (final day in [day1, day2]) {
        buddy = recordSharedFeed(buddy, isA: true, day: day).buddy;
        buddy = recordSharedFeed(buddy, isA: false, day: day).buddy;
      }
      expect(buddy.streak, 2);
      expect(buddy.bestStreak, 2);

      buddy = recordSharedFeed(buddy, isA: false, day: day4).buddy;
      buddy = recordSharedFeed(buddy, isA: true, day: day4).buddy;
      expect(buddy.streak, 1);
      expect(buddy.bestStreak, 2);
    });

    test('feeding on different days does not count', () {
      var buddy = recordSharedFeed(pair(), isA: true, day: day1).buddy;
      final r = recordSharedFeed(buddy, isA: false, day: day2);
      expect(r.extended, isFalse);
    });

    test('an invite that was not accepted never counts', () {
      var buddy = recordSharedFeed(
        pair(accepted: false),
        isA: true,
        day: day1,
      ).buddy;
      expect(recordSharedFeed(buddy, isA: false, day: day1).extended, isFalse);
    });

    test('the streak survives one day and ends after a missed day', () {
      final buddy = pair().copyWith(streak: 3, lastStreakDay: day1);
      expect(liveSharedStreak(buddy, day1), 3);
      expect(liveSharedStreak(buddy, day2), 3);
      expect(liveSharedStreak(buddy, DateTime.utc(2026, 10, 28)), 0);
    });

    test('expiry uses the friend whose day started later', () {
      expect(pairToday(day2, day1), day1);
      expect(pairToday(day1, day2), day1);
    });
  });

  group('league team challenges', () {
    Meal meal(UuidValue owner, int score, int protein, DateTime at) => Meal(
      ownerId: owner,
      name: 'meal',
      description: '',
      calories: 400,
      proteinPct: protein,
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

    LeagueChallenge challengeOfKind(
      String key, {
      List<Meal> meals = const [],
      int duels = 0,
      int members = 2,
    }) {
      // Find a league id that gets this kind of challenge this week
      for (var leagueId = 1; leagueId < 20; leagueId++) {
        final c = weeklyChallenge(
          leagueId: leagueId,
          week: monday,
          memberCount: members,
          fedMeals: meals,
          finishedDuels: duels,
          offsets: {alice: 0, bob: 60},
        );
        if (c.key == key) return c;
      }
      throw StateError('no league gets $key');
    }

    test('the challenge is the same all week and rotates weekly', () {
      final next = monday.add(const Duration(days: 7));
      expect(challengeIndex(3, monday), challengeIndex(3, monday));
      expect(challengeIndex(3, monday), isNot(challengeIndex(3, next)));
    });

    test('good meals counts meals scoring 70 or more', () {
      final meals = [
        for (var i = 0; i < 8; i++)
          meal(i.isEven ? alice : bob, i < 6 ? 80 : 50, 10, monday),
      ];
      final c = challengeOfKind('goodMeals', meals: meals);
      expect(c.target, 8);
      expect(c.progress, 6);
      expect(c.completed, isFalse);
    });

    test('days fed counts each member once per local day', () {
      final meals = [
        meal(alice, 50, 10, monday.add(const Duration(hours: 9))),
        meal(alice, 50, 10, monday.add(const Duration(hours: 12))),
        meal(bob, 50, 10, monday.add(const Duration(hours: 9))),
        meal(bob, 50, 10, monday.add(const Duration(days: 1, hours: 9))),
      ];
      final c = challengeOfKind('daysFed', meals: meals);
      expect(c.progress, 3);
      expect(c.target, 10);
    });

    test('battles is met by finishing enough friend battles', () {
      final c = challengeOfKind('battles', duels: 3, members: 3);
      expect(c.target, 3);
      expect(c.completed, isTrue);
      expect(c.rewardCoins, challengeRewardCoins);
    });

    test('progress never shows past the target', () {
      final c = challengeOfKind('battles', duels: 9);
      expect(c.progress, c.target);
    });

    test('a one-member league still needs a two-member target', () {
      expect(challengeOfKind('battles', members: 1).target, 2);
    });
  });

  group('activity', () {
    test('1000 steps is 1 energy, capped at 10 a day', () {
      expect(activityAwards(999, 0).energy, 0);
      expect(activityAwards(4500, 0).energy, 4);
      expect(activityAwards(25000, 0).energy, maxActivityEnergyPerDay);
    });

    test('7 hours of sleep earns the health bonus', () {
      expect(activityAwards(0, 6 * 60 + 59).health, 0);
      expect(activityAwards(0, 7 * 60).health, sleepHealth);
    });
  });

  group('meal ideas', () {
    NutritionInsights week({int protein = 80, int fiber = 80}) =>
        NutritionInsights(
          mealsCounted: 5,
          daysWithMeals: 4,
          averageHealthScore: 60,
          proteinPct: protein,
          carbsPct: 90,
          fatsPct: 70,
          vitaminsPct: 60,
          mineralsPct: 50,
          fiberPct: fiber,
          bestMealName: 'Jollof',
          tips: const [],
        );

    test('parses the AI answer and drops bad items and nutrients', () {
      final ideas = parseMealIdeas({
        'ideas': [
          {
            'name': ' Moi moi ',
            'reason': 'Bean protein.',
            'boosts': ['Protein', 'sparkle'],
          },
          {'name': '', 'reason': 'x', 'boosts': []},
          'nonsense',
          {
            'name': 'Okra soup',
            'reason': 'Greens.',
            'boosts': ['fiber'],
          },
        ],
      });
      expect(ideas.map((i) => i.name), ['Moi moi', 'Okra soup']);
      expect(ideas.first.boosts, ['protein']);
    });

    test('falls back to ideas for the lowest nutrients first', () {
      final ideas = fallbackMealIdeas(week(protein: 10, fiber: 30));
      expect(ideas, hasLength(mealIdeasCount));
      expect(ideas[0].boosts, ['protein']);
      expect(ideas[1].boosts, ['fiber']);
    });

    test('the prompt includes the locale, meals and gaps', () {
      final prompt = mealIdeasPrompt(
        week: week(protein: 10),
        recentMeals: ['Jollof rice'],
        locale: 'en_NG',
      );
      expect(prompt, contains('en_NG'));
      expect(prompt, contains('Jollof rice'));
      expect(prompt, contains('protein 10%'));
    });

    test('the schema converts to Gemini format', () {
      final gemini = GeminiNutritionAi.toGeminiSchema(mealIdeasSchema);
      expect(gemini['type'], 'OBJECT');
      expect(gemini.containsKey('additionalProperties'), isFalse);
      expect(gemini['propertyOrdering'], ['ideas']);
      final item = (gemini['properties'] as Map)['ideas']['items'] as Map;
      expect(item['type'], 'OBJECT');
      expect(item['propertyOrdering'], ['name', 'reason', 'boosts']);
      expect(item['properties']['boosts']['items']['type'], 'STRING');
    });
  });
}

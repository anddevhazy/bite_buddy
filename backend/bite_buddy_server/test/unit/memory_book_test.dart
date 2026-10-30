import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/memory_book.dart';
import 'package:bite_buddy_server/src/utils/pet_stats.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final owner = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final adopted = DateTime.utc(2026, 9, 1, 10); // a Tuesday

  Pet pet({DateTime? now}) => newPet(
    ownerId: owner,
    speciesKey: 'fluffy',
    name: 'Biscuit',
    now: adopted,
  ).copyWith(level: 3, mealsEaten: 12, bestStreak: 4, wins: 2);

  Meal meal(DateTime at, {int score = 70, int protein = 20}) => Meal(
    ownerId: owner,
    name: 'Meal ${at.day}',
    description: '',
    calories: 400,
    proteinPct: protein,
    carbsPct: 30,
    fatsPct: 20,
    vitaminsPct: 20,
    mineralsPct: 20,
    fiberPct: 20,
    healthScore: score,
    grade: gradeFor(score),
    imageHash: '',
    fed: true,
    createdAt: at,
  );

  MemoryBook book(
    List<Meal> meals, {
    DateTime? now,
    List<LevelUp> levelUps = const [],
    List<ArenaRun> wins = const [],
  }) => buildMemoryBook(
    MemoryInputs(
      pet: pet(),
      fedMeals: meals,
      levelUps: levelUps,
      arenaWins: wins,
      duelWins: const [],
      trophies: const [],
      now: now ?? adopted.add(const Duration(days: 20)),
    ),
  );

  List<String> keys(MemoryBook b) => b.memories.map((m) => m.key).toList();

  test('day 1 vs today and days together', () {
    final b = book([], now: adopted.add(const Duration(days: 9, hours: 1)));
    expect(b.daysTogether, 10);
    expect(b.dayOne.level, 1);
    expect(b.dayOne.mealsEaten, 0);
    expect(b.today.level, 3);
    expect(b.today.wins, 2);
    expect(keys(b), ['adopted']);
  });

  test('first meal, meal counts and first A-grade are remembered', () {
    final meals = [
      for (var i = 0; i < 12; i++)
        meal(adopted.add(Duration(hours: 2 + i * 30)), score: i == 5 ? 90 : 60),
    ];
    final b = book(meals.reversed.toList());
    expect(keys(b), containsAll(['first_meal', 'meals_10', 'first_a']));
    expect(keys(b), isNot(contains('meals_25')));
    final first = b.memories.firstWhere((m) => m.key == 'first_meal');
    expect(first.happenedAt, meals.first.createdAt);
    final tenth = b.memories.firstWhere((m) => m.key == 'meals_10');
    expect(tenth.happenedAt, meals[9].createdAt);
  });

  test('streak milestones are reached on consecutive days only', () {
    final days = [0, 1, 2, 4, 5, 6, 7, 8, 9, 10];
    final b = book([
      for (final d in days) meal(adopted.add(Duration(days: d, hours: 1))),
    ]);
    expect(keys(b), contains('streak_3'));
    expect(keys(b), contains('streak_7'));
    // The second run reached 3 again; it's only remembered once
    expect(keys(b).where((k) => k == 'streak_3'), hasLength(1));
    final seven = b.memories.firstWhere((m) => m.key == 'streak_7');
    expect(seven.happenedAt.day, adopted.add(const Duration(days: 10)).day);
  });

  test('level ups and the first win against each opponent', () {
    ArenaRun win(String key, int day) => ArenaRun(
      ownerId: owner,
      petId: 1,
      opponentKey: key,
      petMaxHp: 1,
      petAttack: 1,
      petDefense: 1,
      startedAt: adopted.add(Duration(days: day)),
      finishedAt: adopted.add(Duration(days: day, minutes: 2)),
      status: ArenaRunStatus.won,
    );
    final b = book(
      [],
      levelUps: [
        LevelUp(
          ownerId: owner,
          level: 2,
          reachedAt: adopted.add(const Duration(days: 2)),
        ),
      ],
      wins: [win('wild_pup', 3), win('wild_pup', 4), win('shadow_beast', 5)],
    );
    expect(keys(b), [
      'adopted',
      'level_2',
      'beat_wild_pup',
      'beat_shadow_beast',
    ]);
    expect(b.memories[2].title, 'First battle won');
    expect(b.levels.map((l) => l.level), [1, 2]);
  });

  test('the calendar starts at adoption and covers every day to today', () {
    final now = adopted.add(const Duration(days: 4));
    final b = book([
      meal(adopted.add(const Duration(hours: 3)), score: 80),
      meal(adopted.add(const Duration(hours: 6)), score: 60),
      meal(adopted.add(const Duration(days: 2, hours: 1))),
    ], now: now);
    expect(b.feedingDays, hasLength(5));
    expect(b.feedingDays.first.meals, 2);
    expect(b.feedingDays.first.averageScore, 70);
    expect(b.feedingDays[1].meals, 0);
  });

  test('weeks count meals, scores and wins from the adoption week', () {
    final b = book([
      meal(adopted.add(const Duration(hours: 1)), score: 80),
      meal(adopted.add(const Duration(days: 8)), score: 60),
    ], now: adopted.add(const Duration(days: 15)));
    expect(b.weeks.first.weekStart, DateTime.utc(2026, 8, 31));
    expect(b.weeks.map((w) => w.meals), [1, 1, 0]);
    expect(b.weeks.last.averageScore, isNull);
  });

  test('nutrient comparison needs two weeks, then compares first and last', () {
    final early = meal(adopted.add(const Duration(hours: 1)), protein: 10);
    final late = meal(adopted.add(const Duration(days: 19)), protein: 60);
    expect(
      book([
        early,
        late,
      ], now: adopted.add(const Duration(days: 10))).firstWeekNutrients,
      isNull,
    );
    final b = book([early, late]);
    expect(b.firstWeekNutrients!.protein, 10);
    expect(b.lastWeekNutrients!.protein, 60);
  });
}

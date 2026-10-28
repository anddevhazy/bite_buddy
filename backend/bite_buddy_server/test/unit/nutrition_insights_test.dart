import 'package:bite_buddy_server/src/generated/protocol.dart';
import 'package:bite_buddy_server/src/utils/nutrition_insights.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  final owner = UuidValue.fromString('11111111-1111-4111-8111-111111111111');
  final t0 = DateTime.utc(2026, 10, 23, 12);

  Meal meal({
    String name = 'Rice and beans',
    int protein = 60,
    int carbs = 60,
    int fats = 30,
    int fiber = 60,
    int score = 70,
    int daysAgo = 0,
  }) => Meal(
    ownerId: owner,
    name: name,
    description: '',
    calories: 500,
    proteinPct: protein,
    carbsPct: carbs,
    fatsPct: fats,
    vitaminsPct: 60,
    mineralsPct: 60,
    fiberPct: fiber,
    healthScore: score,
    grade: 'B',
    imageHash: 'x',
    fed: true,
    createdAt: t0.subtract(Duration(days: daysAgo)),
  );

  NutritionInsights insights(List<Meal> meals) =>
      buildInsights(petName: 'Fluffy', meals: meals, utcOffsetMinutes: 0);

  test('with no meals, it asks for some', () {
    final result = insights([]);
    expect(result.mealsCounted, 0);
    expect(result.tips.single, contains('Feed Fluffy'));
  });

  test('averages per day with meals, not per meal', () {
    // Two meals on one day add up to that day's intake
    final result = insights([meal(protein: 30), meal(protein: 40)]);
    expect(result.daysWithMeals, 1);
    expect(result.proteinPct, 70);
  });

  test('flags the lowest nutrient first, with foods to try', () {
    final days = [
      for (var d = 0; d < 5; d++) meal(protein: 20, fiber: 40, daysAgo: d),
    ];
    final tips = insights(days).tips;
    expect(
      tips.first,
      'Fluffy is low on protein. Try eggs, beans, fish or chicken tomorrow.',
    );
    expect(tips[1], contains('low on fiber'));
  });

  test('flags too much fat', () {
    final days = [for (var d = 0; d < 5; d++) meal(fats: 150, daysAgo: d)];
    expect(insights(days).tips, contains(startsWith('Lots of fat')));
  });

  test('praises a good, balanced week and picks the best meal', () {
    final days = [
      for (var d = 0; d < 5; d++) meal(score: 80, daysAgo: d),
      meal(name: 'Grilled fish and greens', score: 92),
    ];
    final result = insights(days);
    expect(result.tips.single, startsWith('Great week!'));
    expect(result.bestMealName, 'Grilled fish and greens');
    expect(result.averageHealthScore, 82);
  });

  test('never gives more than 3 tips', () {
    final result = insights([
      meal(protein: 0, fiber: 0, fats: 200, carbs: 300),
    ]);
    expect(result.tips, hasLength(3));
  });
}

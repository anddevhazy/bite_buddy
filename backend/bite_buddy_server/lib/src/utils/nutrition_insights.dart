import '../generated/protocol.dart';
import 'pet_stats.dart';

// Weekly summary and tips, worked out from the meals the pet ate. Plain rules
// rather than another AI call, so they're free and instant.

const int insightsDays = 7;
// Average daily intake below this percent of the target counts as low
const int lowPct = 50;
const int highFatsPct = 120;
const int highCarbsPct = 140;
const int maxTips = 3;

const _foodsFor = {
  'protein': 'eggs, beans, fish or chicken',
  'fiber': 'beans, oats, vegetables or fruit',
  'vitamins': 'fruit, peppers or leafy greens',
  'minerals': 'nuts, seeds, leafy greens or plantain',
};

// [meals] are the fed meals from the last [insightsDays] days
NutritionInsights buildInsights({
  required String petName,
  required List<Meal> meals,
  required int utcOffsetMinutes,
}) {
  if (meals.isEmpty) {
    return NutritionInsights(
      mealsCounted: 0,
      daysWithMeals: 0,
      averageHealthScore: 0,
      proteinPct: 0,
      carbsPct: 0,
      fatsPct: 0,
      vitaminsPct: 0,
      mineralsPct: 0,
      fiberPct: 0,
      bestMealName: null,
      tips: ['Feed $petName a few meals to get tips here.'],
    );
  }

  final days = {
    for (final m in meals) localDay(m.createdAt, utcOffsetMinutes),
  }.length;
  int perDay(int Function(Meal) pct) =>
      (meals.fold(0, (sum, m) => sum + pct(m)) / days).round();

  final protein = perDay((m) => m.proteinPct);
  final carbs = perDay((m) => m.carbsPct);
  final fats = perDay((m) => m.fatsPct);
  final vitamins = perDay((m) => m.vitaminsPct);
  final minerals = perDay((m) => m.mineralsPct);
  final fiber = perDay((m) => m.fiberPct);
  final averageScore =
      (meals.fold(0, (sum, m) => sum + m.healthScore) / meals.length).round();
  final best = meals.reduce((a, b) => b.healthScore > a.healthScore ? b : a);

  // Lowest nutrient first, since that's the one most worth fixing
  final lows = [
    ('protein', protein),
    ('fiber', fiber),
    ('vitamins', vitamins),
    ('minerals', minerals),
  ].where((n) => n.$2 < lowPct).toList()..sort((a, b) => a.$2.compareTo(b.$2));

  final tips = [
    for (final (name, _) in lows)
      '$petName is low on $name. Try ${_foodsFor[name]} tomorrow.',
    if (fats > highFatsPct)
      'Lots of fat lately. Swap fried food for grilled, boiled or steamed.',
    if (carbs > highCarbsPct)
      'Heavy on carbs. Add some vegetables or protein to balance your plate.',
    if (lows.isEmpty && averageScore >= 75)
      'Great week! $petName is thriving on your meals. Keep it up!',
    if (days < 4) 'Feed $petName every day to build your streak.',
  ];
  if (tips.isEmpty) {
    tips.add('A balanced week. More A and B meals will raise nutrition.');
  }

  return NutritionInsights(
    mealsCounted: meals.length,
    daysWithMeals: days,
    averageHealthScore: averageScore,
    proteinPct: protein,
    carbsPct: carbs,
    fatsPct: fats,
    vitaminsPct: vitamins,
    mineralsPct: minerals,
    fiberPct: fiber,
    bestMealName: best.name,
    tips: tips.take(maxTips).toList(),
  );
}

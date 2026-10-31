import '../generated/protocol.dart';

// AI meal ideas: the prompt, the answer's shape, and a rule-based fallback
// for when the AI is unavailable.

const int mealIdeasCount = 3;

const mealIdeasSystemPrompt = '''
You suggest meals in Bite Buddy, a game where people feed a virtual pet with photos of the meals they eat. Suggest simple, affordable, everyday meals that fill the gaps in the user's week. Suggest Nigerian dishes by default: most users are in Nigeria, and many phones there report a US or UK locale. Only suggest another country's food if the locale's region clearly names that other country (not US or GB) and their recent meals are mostly from it too. Lean towards the kinds of dishes they already eat, so the ideas feel familiar and easy to find or cook in a Nigerian market or kitchen. Each name is a short dish name. Each reason is one friendly sentence of at most 15 words that says which gap it fills. boosts lists the nutrients it raises, from: protein, carbs, fats, vitamins, minerals, fiber.''';

// Standard JSON schema; each AI provider converts it to its own format
const mealIdeasSchema = <String, dynamic>{
  'type': 'object',
  'properties': {
    'ideas': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {
          'name': {'type': 'string'},
          'reason': {'type': 'string'},
          'boosts': {
            'type': 'array',
            'items': {'type': 'string'},
          },
        },
        'required': ['name', 'reason', 'boosts'],
        'additionalProperties': false,
      },
    },
  },
  'required': ['ideas'],
  'additionalProperties': false,
};

String mealIdeasPrompt({
  required NutritionInsights week,
  required List<String> recentMeals,
  required String locale,
}) {
  final meals = recentMeals.isEmpty ? 'none yet' : recentMeals.join(', ');
  return '''
Locale: $locale
Meals from the last 7 days: $meals
Average share of the daily target per day: protein ${week.proteinPct}%, carbs ${week.carbsPct}%, fats ${week.fatsPct}%, vitamins ${week.vitaminsPct}%, minerals ${week.mineralsPct}%, fiber ${week.fiberPct}%.
Suggest $mealIdeasCount meals for today.''';
}

const _validBoosts = {
  'protein',
  'carbs',
  'fats',
  'vitamins',
  'minerals',
  'fiber',
};

// Reads the AI's answer, dropping anything malformed
List<MealSuggestion> parseMealIdeas(Map<String, dynamic> json) {
  final ideas = <MealSuggestion>[];
  for (final item in (json['ideas'] as List? ?? const [])) {
    if (item is! Map) continue;
    final name = item['name'];
    final reason = item['reason'];
    if (name is! String || reason is! String || name.trim().isEmpty) continue;
    ideas.add(
      MealSuggestion(
        name: name.trim(),
        reason: reason.trim(),
        boosts: [
          for (final b in (item['boosts'] as List? ?? const []))
            if (b is String && _validBoosts.contains(b.toLowerCase()))
              b.toLowerCase(),
        ],
      ),
    );
  }
  return ideas.take(mealIdeasCount).toList();
}

// Nigerian, like the AI's ideas (see mealIdeasSystemPrompt)
const _fallbackIdeas = {
  'protein': (
    'Moi moi with boiled eggs',
    'Beans and eggs: an easy protein boost.',
  ),
  'fiber': (
    'Beans and plantain',
    'Beans are packed with fiber to keep you full.',
  ),
  'vitamins': ('Pawpaw and oranges', 'Fresh fruit full of vitamins.'),
  'minerals': (
    'Efo riro with fish',
    'Leafy greens and fish for a mineral boost.',
  ),
};

// Used when the AI can't answer: one idea per low nutrient, lowest first
List<MealSuggestion> fallbackMealIdeas(NutritionInsights week) {
  final levels = {
    'protein': week.proteinPct,
    'fiber': week.fiberPct,
    'vitamins': week.vitaminsPct,
    'minerals': week.mineralsPct,
  };
  final order = levels.keys.toList()
    ..sort((a, b) => levels[a]!.compareTo(levels[b]!));
  return [
    for (final key in order.take(mealIdeasCount))
      MealSuggestion(
        name: _fallbackIdeas[key]!.$1,
        reason: _fallbackIdeas[key]!.$2,
        boosts: [key],
      ),
  ];
}

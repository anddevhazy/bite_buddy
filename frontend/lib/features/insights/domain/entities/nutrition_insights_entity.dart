import 'package:equatable/equatable.dart';

// The last 7 days of meals the pet ate, summarised, with tips
class NutritionInsightsEntity extends Equatable {
  final int mealsCounted;
  final int daysWithMeals;
  // 0-100, or 0 when there are no meals
  final int averageHealthScore;
  // Average per day with meals, as a percent of the daily target
  final int proteinPct;
  final int carbsPct;
  final int fatsPct;
  final int vitaminsPct;
  final int mineralsPct;
  final int fiberPct;
  final String? bestMealName;
  // Most important first
  final List<String> tips;

  const NutritionInsightsEntity({
    required this.mealsCounted,
    required this.daysWithMeals,
    required this.averageHealthScore,
    required this.proteinPct,
    required this.carbsPct,
    required this.fatsPct,
    required this.vitaminsPct,
    required this.mineralsPct,
    required this.fiberPct,
    required this.tips,
    this.bestMealName,
  });

  @override
  List<Object?> get props => [
    mealsCounted,
    daysWithMeals,
    averageHealthScore,
    proteinPct,
    carbsPct,
    fatsPct,
    vitaminsPct,
    mineralsPct,
    fiberPct,
    bestMealName,
    tips,
  ];
}

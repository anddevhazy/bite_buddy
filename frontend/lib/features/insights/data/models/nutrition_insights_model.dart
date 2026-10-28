import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class NutritionInsightsModel extends NutritionInsightsEntity {
  const NutritionInsightsModel({
    required super.mealsCounted,
    required super.daysWithMeals,
    required super.averageHealthScore,
    required super.proteinPct,
    required super.carbsPct,
    required super.fatsPct,
    required super.vitaminsPct,
    required super.mineralsPct,
    required super.fiberPct,
    required super.tips,
    super.bestMealName,
  });

  factory NutritionInsightsModel.fromProtocol(NutritionInsights insights) {
    return NutritionInsightsModel(
      mealsCounted: insights.mealsCounted,
      daysWithMeals: insights.daysWithMeals,
      averageHealthScore: insights.averageHealthScore,
      proteinPct: insights.proteinPct,
      carbsPct: insights.carbsPct,
      fatsPct: insights.fatsPct,
      vitaminsPct: insights.vitaminsPct,
      mineralsPct: insights.mineralsPct,
      fiberPct: insights.fiberPct,
      tips: insights.tips,
      bestMealName: insights.bestMealName,
    );
  }
}

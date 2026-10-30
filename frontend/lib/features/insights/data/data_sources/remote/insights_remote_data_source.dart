import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';

abstract class InsightsRemoteDataSource {
  Future<NutritionInsightsEntity> fetchInsights();

  Future<List<MealIdeaEntity>> fetchMealIdeas();
}

import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';

abstract class InsightsRemoteDataSource {
  Future<NutritionInsightsEntity> fetchInsights();
}

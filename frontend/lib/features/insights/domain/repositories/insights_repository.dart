import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:dartz/dartz.dart';

abstract class InsightsRepository {
  Future<Either<Failure, NutritionInsightsEntity>> fetchInsights();

  Future<Either<Failure, List<MealIdeaEntity>>> fetchMealIdeas();
}

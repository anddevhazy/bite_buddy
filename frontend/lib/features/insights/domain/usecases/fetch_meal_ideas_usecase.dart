import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/repositories/insights_repository.dart';
import 'package:dartz/dartz.dart';

class FetchMealIdeasUseCase {
  final InsightsRepository repository;

  FetchMealIdeasUseCase({required this.repository});

  Future<Either<Failure, List<MealIdeaEntity>>> call() =>
      repository.fetchMealIdeas();
}

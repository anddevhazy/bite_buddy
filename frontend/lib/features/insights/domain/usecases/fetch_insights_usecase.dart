import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy/features/insights/domain/repositories/insights_repository.dart';
import 'package:dartz/dartz.dart';

class FetchInsightsUseCase {
  final InsightsRepository repository;

  FetchInsightsUseCase({required this.repository});

  Future<Either<Failure, NutritionInsightsEntity>> call() =>
      repository.fetchInsights();
}

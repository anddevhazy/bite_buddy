import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/data/data_sources/remote/insights_remote_data_source.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy/features/insights/domain/repositories/insights_repository.dart';
import 'package:dartz/dartz.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  final InsightsRemoteDataSource remoteDataSource;

  InsightsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, NutritionInsightsEntity>> fetchInsights() async {
    try {
      return Right(await remoteDataSource.fetchInsights());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MealIdeaEntity>>> fetchMealIdeas() async {
    try {
      return Right(await remoteDataSource.fetchMealIdeas());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

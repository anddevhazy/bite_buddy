import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<LeaderboardEntryEntity>>> fetchLeaderboard();

  Future<Either<Failure, List<MealEntity>>> fetchMealHistory();
}

import 'package:bite_buddy/features/collection/data/data_sources/remote/collection_remote_data_source.dart';
import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/collection/domain/repositories/collection_repository.dart';
import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:dartz/dartz.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDataSource remoteDataSource;

  CollectionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LeaderboardEntryEntity>>>
  fetchLeaderboard() async {
    try {
      return Right(await remoteDataSource.fetchLeaderboard());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MealEntity>>> fetchMealHistory() async {
    try {
      return Right(await remoteDataSource.fetchMealHistory());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

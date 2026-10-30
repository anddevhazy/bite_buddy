import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/data/data_sources/remote/streak_remote_data_source.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:dartz/dartz.dart';

class StreakRepositoryImpl implements StreakRepository {
  final StreakRemoteDataSource remoteDataSource;

  StreakRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SharedStreakEntity>>> fetchStreaks() async {
    try {
      return Right(await remoteDataSource.fetchStreaks());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<StreakFriendEntity>>> fetchCandidates() async {
    try {
      return Right(await remoteDataSource.fetchCandidates());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, SharedStreakEntity>> invite(
    String friendUserId,
  ) async {
    try {
      return Right(await remoteDataSource.invite(friendUserId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, SharedStreakEntity>> accept(int streakId) async {
    try {
      return Right(await remoteDataSource.accept(streakId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> remove(int streakId) async {
    try {
      await remoteDataSource.remove(streakId);
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

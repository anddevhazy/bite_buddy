import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:dartz/dartz.dart';

abstract class StreakRepository {
  Future<Either<Failure, List<SharedStreakEntity>>> fetchStreaks();

  Future<Either<Failure, List<StreakFriendEntity>>> fetchCandidates();

  Future<Either<Failure, SharedStreakEntity>> invite(String friendUserId);

  Future<Either<Failure, SharedStreakEntity>> accept(int streakId);

  Future<Either<Failure, Unit>> remove(int streakId);
}

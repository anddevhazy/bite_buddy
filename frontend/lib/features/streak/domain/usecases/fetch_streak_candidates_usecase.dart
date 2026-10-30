import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:dartz/dartz.dart';

class FetchStreakCandidatesUseCase {
  final StreakRepository repository;

  FetchStreakCandidatesUseCase({required this.repository});

  Future<Either<Failure, List<StreakFriendEntity>>> call() =>
      repository.fetchCandidates();
}

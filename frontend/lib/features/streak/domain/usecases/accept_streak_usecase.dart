import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:dartz/dartz.dart';

class AcceptStreakUseCase {
  final StreakRepository repository;

  AcceptStreakUseCase({required this.repository});

  Future<Either<Failure, SharedStreakEntity>> call(int streakId) =>
      repository.accept(streakId);
}

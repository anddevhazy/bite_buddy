import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:dartz/dartz.dart';

// Declines an invite, cancels one, or ends a shared streak
class RemoveStreakUseCase {
  final StreakRepository repository;

  RemoveStreakUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int streakId) =>
      repository.remove(streakId);
}

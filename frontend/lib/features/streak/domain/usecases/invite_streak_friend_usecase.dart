import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:dartz/dartz.dart';

class InviteStreakFriendUseCase {
  final StreakRepository repository;

  InviteStreakFriendUseCase({required this.repository});

  Future<Either<Failure, SharedStreakEntity>> call(String friendUserId) =>
      repository.invite(friendUserId);
}

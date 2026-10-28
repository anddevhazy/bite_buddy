import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveFriendUseCase {
  final SocialRepository repository;

  RemoveFriendUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int friendshipId) =>
      repository.removeFriend(friendshipId);
}

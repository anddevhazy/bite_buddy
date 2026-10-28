import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class AcceptFriendUseCase {
  final SocialRepository repository;

  AcceptFriendUseCase({required this.repository});

  Future<Either<Failure, FriendEntity>> call(int friendshipId) =>
      repository.acceptFriend(friendshipId);
}

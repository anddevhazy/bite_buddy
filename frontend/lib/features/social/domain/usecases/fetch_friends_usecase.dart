import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:dartz/dartz.dart';

class FetchFriendsUseCase {
  final SocialRepository repository;

  FetchFriendsUseCase({required this.repository});

  Future<Either<Failure, List<FriendEntity>>> call() =>
      repository.fetchFriends();
}

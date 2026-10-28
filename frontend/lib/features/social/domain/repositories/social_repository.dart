import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SocialRepository {
  Future<Either<Failure, String>> fetchFriendCode();

  // Incoming requests first, then friends, then requests you sent
  Future<Either<Failure, List<FriendEntity>>> fetchFriends();

  // Accepts their request instead if they'd already asked you
  Future<Either<Failure, FriendEntity>> addFriend(String friendCode);

  Future<Either<Failure, FriendEntity>> acceptFriend(int friendshipId);

  // Unfriend, decline, or cancel a request
  Future<Either<Failure, Unit>> removeFriend(int friendshipId);

  Future<Either<Failure, List<ChallengeEntity>>> fetchChallenges();

  Future<Either<Failure, ChallengeEntity>> createChallenge(String name, int days);

  Future<Either<Failure, ChallengeEntity>> joinChallenge(String code);

  Future<Either<Failure, Unit>> leaveChallenge(int challengeId);
}

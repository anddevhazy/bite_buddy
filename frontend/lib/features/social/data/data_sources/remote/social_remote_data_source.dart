import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';

abstract class SocialRemoteDataSource {
  Future<String> fetchFriendCode();
  Future<List<FriendEntity>> fetchFriends();
  Future<FriendEntity> addFriend(String friendCode);
  Future<FriendEntity> acceptFriend(int friendshipId);
  Future<void> removeFriend(int friendshipId);

  Future<List<ChallengeEntity>> fetchChallenges();
  Future<ChallengeEntity> createChallenge(String name, int days);
  Future<ChallengeEntity> joinChallenge(String code);
  Future<void> leaveChallenge(int challengeId);
}

import 'package:bite_buddy/features/social/data/data_sources/remote/social_remote_data_source.dart';
import 'package:bite_buddy/features/social/data/models/challenge_model.dart';
import 'package:bite_buddy/features/social/data/models/friend_model.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class SocialRemoteDataSourceImpl implements SocialRemoteDataSource {
  final Client client;

  SocialRemoteDataSourceImpl({required this.client});

  @override
  Future<String> fetchFriendCode() => client.friend.myCode();

  @override
  Future<List<FriendEntity>> fetchFriends() async {
    final friends = await client.friend.list();
    return friends.map(FriendModel.fromProtocol).toList();
  }

  @override
  Future<FriendEntity> addFriend(String friendCode) async {
    return FriendModel.fromProtocol(await client.friend.add(friendCode));
  }

  @override
  Future<FriendEntity> acceptFriend(int friendshipId) async {
    return FriendModel.fromProtocol(await client.friend.accept(friendshipId));
  }

  @override
  Future<void> removeFriend(int friendshipId) =>
      client.friend.remove(friendshipId);

  @override
  Future<List<ChallengeEntity>> fetchChallenges() async {
    final challenges = await client.challenge.mine();
    return challenges.map(ChallengeModel.fromProtocol).toList();
  }

  @override
  Future<ChallengeEntity> createChallenge(String name, int days) async {
    return ChallengeModel.fromProtocol(
      await client.challenge.create(name, days),
    );
  }

  @override
  Future<ChallengeEntity> joinChallenge(String code) async {
    return ChallengeModel.fromProtocol(await client.challenge.join(code));
  }

  @override
  Future<void> leaveChallenge(int challengeId) =>
      client.challenge.leave(challengeId);
}

import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart' as api;

class FriendModel extends FriendEntity {
  const FriendModel({
    required super.friendshipId,
    required super.status,
    required super.petId,
    required super.petName,
    required super.speciesKey,
    required super.level,
    required super.nutrition,
    required super.streak,
    required super.sharedStreak,
  });

  factory FriendModel.fromProtocol(api.Friend friend) {
    return FriendModel(
      friendshipId: friend.friendshipId,
      status: switch (friend.status) {
        api.FriendStatus.friends => FriendStatus.friends,
        api.FriendStatus.incoming => FriendStatus.incoming,
        api.FriendStatus.outgoing => FriendStatus.outgoing,
      },
      petId: friend.petId,
      petName: friend.petName,
      speciesKey: friend.speciesKey,
      level: friend.level,
      nutrition: friend.nutrition,
      streak: friend.streak,
      sharedStreak: friend.sharedStreak,
    );
  }
}

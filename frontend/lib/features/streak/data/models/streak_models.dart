import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Converts the generated server models into this feature's entities
class StreakModels {
  static SharedStreakEntity streak(StreakBuddyView s) => SharedStreakEntity(
    id: s.id,
    status: switch (s.status) {
      StreakBuddyStatus.active => SharedStreakStatus.active,
      StreakBuddyStatus.invited => SharedStreakStatus.invited,
      StreakBuddyStatus.incoming => SharedStreakStatus.incoming,
    },
    friendPetName: s.friendPetName,
    friendSpeciesKey: s.friendSpeciesKey,
    streak: s.streak,
    bestStreak: s.bestStreak,
    youFedToday: s.youFedToday,
    friendFedToday: s.friendFedToday,
  );

  static StreakFriendEntity friend(StreakFriend f) => StreakFriendEntity(
    userId: f.userId.toString(),
    petName: f.petName,
    speciesKey: f.speciesKey,
  );
}

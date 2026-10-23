import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class LeaderboardEntryModel extends LeaderboardEntryEntity {
  const LeaderboardEntryModel({
    required super.rank,
    required super.petId,
    required super.petName,
    required super.speciesKey,
    required super.level,
    required super.nutrition,
    required super.isYou,
  });

  factory LeaderboardEntryModel.fromProtocol(LeaderboardEntry entry) {
    return LeaderboardEntryModel(
      rank: entry.rank,
      petId: entry.petId,
      petName: entry.petName,
      speciesKey: entry.speciesKey,
      level: entry.level,
      nutrition: entry.nutrition,
      isYou: entry.isYou,
    );
  }
}

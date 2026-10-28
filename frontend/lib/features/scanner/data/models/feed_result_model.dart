import 'package:bite_buddy/features/pet/data/models/pet_model.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class FeedResultModel extends FeedResultEntity {
  const FeedResultModel({
    required super.pet,
    required super.healthChange,
    required super.energyChange,
    required super.nutritionChange,
    required super.xpGained,
    required super.leveledUp,
    required super.streakExtended,
    required super.streakBonusXp,
    required super.fullHealthBonusXp,
  });

  factory FeedResultModel.fromProtocol(FeedResult result) {
    return FeedResultModel(
      pet: PetModel.fromProtocol(result.pet),
      healthChange: result.healthChange,
      energyChange: result.energyChange,
      nutritionChange: result.nutritionChange,
      xpGained: result.xpGained,
      leveledUp: result.leveledUp,
      streakExtended: result.streakExtended,
      streakBonusXp: result.streakBonusXp,
      fullHealthBonusXp: result.fullHealthBonusXp,
    );
  }
}

import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class PetModel extends PetEntity {
  const PetModel({
    required super.id,
    required super.speciesKey,
    required super.name,
    required super.level,
    required super.xp,
    required super.xpToNextLevel,
    required super.health,
    required super.energy,
    required super.nutrition,
    required super.coins,
    required super.mealsEaten,
    required super.wins,
    required super.losses,
    super.lastFedAt,
  });

  // A level needs level * 100 XP (same rule as the server's pet_stats.dart)
  factory PetModel.fromProtocol(Pet pet) {
    return PetModel(
      id: pet.id!,
      speciesKey: pet.speciesKey,
      name: pet.name,
      level: pet.level,
      xp: pet.xp,
      xpToNextLevel: pet.level * 100,
      health: pet.health,
      energy: pet.energy,
      nutrition: pet.nutrition,
      coins: pet.coins,
      mealsEaten: pet.mealsEaten,
      wins: pet.wins,
      losses: pet.losses,
      lastFedAt: pet.lastFedAt?.toLocal(),
    );
  }
}

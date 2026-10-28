import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:equatable/equatable.dart';

class FeedResultEntity extends Equatable {
  final PetEntity pet;
  final int healthChange;
  final int energyChange;
  final int nutritionChange;
  final int xpGained;
  final bool leveledUp;
  // True for the first meal of a new streak day
  final bool streakExtended;
  // Already included in xpGained
  final int streakBonusXp;

  const FeedResultEntity({
    required this.pet,
    required this.healthChange,
    required this.energyChange,
    required this.nutritionChange,
    required this.xpGained,
    required this.leveledUp,
    required this.streakExtended,
    required this.streakBonusXp,
  });

  @override
  List<Object?> get props => [
    pet,
    healthChange,
    energyChange,
    nutritionChange,
    xpGained,
    leveledUp,
    streakExtended,
    streakBonusXp,
  ];
}

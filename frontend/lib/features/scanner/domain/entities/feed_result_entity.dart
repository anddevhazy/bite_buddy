import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:equatable/equatable.dart';

class FeedResultEntity extends Equatable {
  final PetEntity pet;
  final int healthChange;
  final int energyChange;
  final int nutritionChange;
  final int xpGained;
  final bool leveledUp;

  const FeedResultEntity({
    required this.pet,
    required this.healthChange,
    required this.energyChange,
    required this.nutritionChange,
    required this.xpGained,
    required this.leveledUp,
  });

  @override
  List<Object?> get props => [
    pet,
    healthChange,
    energyChange,
    nutritionChange,
    xpGained,
    leveledUp,
  ];
}

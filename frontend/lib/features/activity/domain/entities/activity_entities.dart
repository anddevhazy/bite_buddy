import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:equatable/equatable.dart';

// Today's steps and last night's sleep, and what they've done for the pet
class ActivitySyncEntity extends Equatable {
  final PetEntity pet;
  final int steps;
  final int sleepMinutes;
  // From this sync only
  final int energyGained;
  final int healthGained;
  // Today's totals so far, out of the daily caps
  final int energyToday;
  final int healthToday;
  final int maxEnergyPerDay;
  final int maxHealthPerDay;

  const ActivitySyncEntity({
    required this.pet,
    required this.steps,
    required this.sleepMinutes,
    required this.energyGained,
    required this.healthGained,
    required this.energyToday,
    required this.healthToday,
    required this.maxEnergyPerDay,
    required this.maxHealthPerDay,
  });

  @override
  List<Object?> get props => [
    pet,
    steps,
    sleepMinutes,
    energyToday,
    healthToday,
  ];
}

enum HealthSource {
  // Apple Health on iPhone
  appleHealth,
  // Health Connect on Android
  healthConnect,
}

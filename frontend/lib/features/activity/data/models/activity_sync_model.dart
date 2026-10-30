import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/pet/data/models/pet_model.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class ActivitySyncModel extends ActivitySyncEntity {
  const ActivitySyncModel({
    required super.pet,
    required super.steps,
    required super.sleepMinutes,
    required super.energyGained,
    required super.healthGained,
    required super.energyToday,
    required super.healthToday,
    required super.maxEnergyPerDay,
    required super.maxHealthPerDay,
  });

  factory ActivitySyncModel.fromProtocol(ActivitySyncResult r) {
    return ActivitySyncModel(
      pet: PetModel.fromProtocol(r.pet),
      steps: r.steps,
      sleepMinutes: r.sleepMinutes,
      energyGained: r.energyGained,
      healthGained: r.healthGained,
      energyToday: r.energyToday,
      healthToday: r.healthToday,
      maxEnergyPerDay: r.maxEnergyPerDay,
      maxHealthPerDay: r.maxHealthPerDay,
    );
  }
}

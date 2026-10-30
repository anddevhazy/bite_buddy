import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/activity_rules.dart';
import '../utils/pet_stats.dart';
import 'pet_service.dart';

// Steps and sleep from Apple Health or Health Connect. The phone sends
// today's totals whenever the app opens; each sync pays out only what the
// day has earned beyond earlier syncs.
class ActivityService {
  final PetService pets;

  const ActivityService({required this.pets});

  Future<ActivitySyncResult> sync(
    Session session,
    UuidValue ownerId, {
    required int steps,
    required int sleepMinutes,
    required int utcOffsetMinutes,
  }) async {
    if (steps < 0 || sleepMinutes < 0) {
      throw invalidInputError('Steps and sleep must not be negative.');
    }
    final offset = utcOffsetMinutes.clamp(
      minUtcOffsetMinutes,
      maxUtcOffsetMinutes,
    );

    return session.db.transaction((transaction) async {
      final pet = await pets.requireMine(
        session,
        ownerId,
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      final day = localDay(now, offset);

      final existing = await ActivityDay.db.findFirstRow(
        session,
        where: (t) => t.ownerId.equals(ownerId) & t.day.equals(day),
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      );
      // Totals only go up during a day, even if a later reading is lower
      final daySteps = [
        existing?.steps ?? 0,
        steps.clamp(0, maxStepsPerDay),
      ].reduce((a, b) => a > b ? a : b);
      final daySleep = [
        existing?.sleepMinutes ?? 0,
        sleepMinutes.clamp(0, maxSleepMinutes),
      ].reduce((a, b) => a > b ? a : b);

      final earned = activityAwards(daySteps, daySleep);
      final energyGained = earned.energy - (existing?.energyAwarded ?? 0);
      final healthGained = earned.health - (existing?.healthAwarded ?? 0);

      final row = ActivityDay(
        id: existing?.id,
        ownerId: ownerId,
        day: day,
        steps: daySteps,
        sleepMinutes: daySleep,
        energyAwarded: earned.energy,
        healthAwarded: earned.health,
        updatedAt: now,
      );
      if (existing == null) {
        await ActivityDay.db.insertRow(session, row, transaction: transaction);
      } else {
        await ActivityDay.db.updateRow(session, row, transaction: transaction);
      }

      var saved = pet;
      if (energyGained > 0 || healthGained > 0) {
        saved = await Pet.db.updateRow(
          session,
          pet.copyWith(
            energy: clampStat(pet.energy + energyGained),
            health: clampStat(pet.health + healthGained),
          ),
          transaction: transaction,
        );
      }
      return ActivitySyncResult(
        pet: saved,
        steps: daySteps,
        sleepMinutes: daySleep,
        // What actually changed, since stats stop at 100
        energyGained: saved.energy - pet.energy,
        healthGained: saved.health - pet.health,
        energyToday: earned.energy,
        healthToday: earned.health,
        maxEnergyPerDay: maxActivityEnergyPerDay,
        maxHealthPerDay: sleepHealth,
      );
    });
  }
}

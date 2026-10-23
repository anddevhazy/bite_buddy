import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/pet_stats.dart' as stats;
import 'nutrition_ai_service.dart';
import 'pet_service.dart';

class MealService {
  final NutritionAiService ai;
  final PetService pets;

  const MealService({required this.ai, required this.pets});

  static const int maxImageBytes = 4 * 1024 * 1024;
  // Real phone photos are never this small; tiny images are usually thumbnails
  static const int minImageBytes = 20 * 1024;
  // A scan has to be fed soon after, so meals can't be stockpiled
  static const Duration feedWindow = Duration(hours: 3);
  // Stops farming stats by scanning snack after snack
  static const int maxMealsPerDay = 8;

  Future<Meal> analyze(
    Session session,
    UuidValue ownerId,
    ByteData image,
  ) async {
    await pets.requireMine(session, ownerId);

    final bytes = image.buffer.asUint8List(
      image.offsetInBytes,
      image.lengthInBytes,
    );
    if (bytes.length > maxImageBytes) {
      throw invalidInputError('That photo is too large.');
    }
    if (bytes.length < minImageBytes) {
      throw conflictError(
        'MEAL_REJECTED',
        'That image is too small. Take a photo of your meal with the camera.',
      );
    }
    if (!_isJpeg(bytes)) {
      throw invalidInputError('Photos must be JPEG.');
    }

    final imageHash = sha256.convert(bytes).toString();
    final seen = await Meal.db.findFirstRow(
      session,
      where: (t) => t.imageHash.equals(imageHash),
    );
    if (seen != null) {
      throw conflictError(
        'DUPLICATE_PHOTO',
        'This photo has already been scanned. Snap a new one!',
      );
    }

    final analysis = await ai.analyze(session, bytes);
    if (!analysis.isFood || !analysis.isLivePhoto) {
      throw conflictError(
        'MEAL_REJECTED',
        analysis.rejectionReason.isNotEmpty
            ? analysis.rejectionReason
            : 'Only live photos of your meal can be scanned.',
      );
    }

    return Meal.db.insertRow(
      session,
      Meal(
        ownerId: ownerId,
        name: analysis.name,
        description: analysis.description,
        calories: analysis.calories,
        proteinPct: analysis.proteinPct,
        carbsPct: analysis.carbsPct,
        fatsPct: analysis.fatsPct,
        vitaminsPct: analysis.vitaminsPct,
        mineralsPct: analysis.mineralsPct,
        fiberPct: analysis.fiberPct,
        healthScore: analysis.healthScore,
        grade: stats.gradeFor(analysis.healthScore),
        imageHash: imageHash,
        fed: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<FeedResult> feed(
    Session session,
    UuidValue ownerId,
    int mealId,
  ) async {
    return session.db.transaction((transaction) async {
      final meal = await Meal.db.findById(
        session,
        mealId,
        transaction: transaction,
      );
      if (meal == null || meal.ownerId != ownerId) {
        throw notFoundError('Meal');
      }
      if (meal.fed) {
        throw conflictError('ALREADY_FED', 'This meal was already eaten.');
      }

      final now = DateTime.now().toUtc();
      if (now.difference(meal.createdAt) > feedWindow) {
        throw conflictError(
          'MEAL_EXPIRED',
          'This scan is too old to feed. Scan your next meal instead.',
        );
      }

      final fedToday = await Meal.db.count(
        session,
        where:
            (t) =>
                t.ownerId.equals(ownerId) &
                t.fed.equals(true) &
                (t.createdAt > now.subtract(const Duration(days: 1))),
        transaction: transaction,
      );
      if (fedToday >= maxMealsPerDay) {
        throw conflictError(
          'TOO_MANY_MEALS',
          "Your buddy is full! Come back for your next meal tomorrow.",
        );
      }

      final pet = await pets.requireMine(
        session,
        ownerId,
        transaction: transaction,
      );
      final result = stats.feed(pet, meal, now);

      final savedPet = await Pet.db.updateRow(
        session,
        result.pet,
        transaction: transaction,
      );
      await Meal.db.updateRow(
        session,
        meal.copyWith(fed: true),
        transaction: transaction,
      );

      return result.copyWith(pet: savedPet);
    });
  }

  Future<List<Meal>> history(Session session, UuidValue ownerId) {
    return Meal.db.find(
      session,
      where: (t) => t.ownerId.equals(ownerId),
      orderByList: (t) => [t.createdAt.desc()],
      limit: 50,
    );
  }

  bool _isJpeg(Uint8List bytes) =>
      bytes.length > 3 && bytes[0] == 0xFF && bytes[1] == 0xD8;
}

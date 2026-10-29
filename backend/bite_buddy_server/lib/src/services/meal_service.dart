import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/nutrition_insights.dart';
import '../utils/photo_fingerprint.dart';
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
  // Photos whose fingerprints differ in this many of 64 bits or fewer are
  // treated as the same plate (see utils/photo_fingerprint.dart)
  static const int maxSamePlateDistance = 10;

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

    // A new photo of a plate that was already scanned (the loophole the exact
    // match above misses). Checked before the AI call, so it costs nothing.
    final fingerprint = photoFingerprint(bytes);
    if (fingerprint != null) {
      await _rejectIfRecentlyScanned(session, ownerId, fingerprint);
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
        photoFingerprint: fingerprint,
        fed: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  // Rejects the photo if it's a near-copy of one of the owner's scans from the
  // last [feedWindow] (the window in which a meal can still be fed)
  Future<void> _rejectIfRecentlyScanned(
    Session session,
    UuidValue ownerId,
    String fingerprint,
  ) async {
    final since = DateTime.now().toUtc().subtract(feedWindow);
    final recent = await Meal.db.find(
      session,
      where: (t) =>
          t.ownerId.equals(ownerId) &
          (t.createdAt > since) &
          t.photoFingerprint.notEquals(null),
    );
    for (final meal in recent) {
      if (fingerprintDistance(fingerprint, meal.photoFingerprint!) <=
          maxSamePlateDistance) {
        throw conflictError(
          'DUPLICATE_PHOTO',
          meal.fed
              ? 'Looks like you already fed ${meal.name} from this plate. '
                    'Scan your next meal!'
              : 'You already scanned this plate. Feed it from your meal log '
                    '(Collection, Meals tab).',
        );
      }
    }
  }

  // [utcOffsetMinutes] is the phone's offset from UTC, so the streak follows
  // the user's own calendar days
  Future<FeedResult> feed(
    Session session,
    UuidValue ownerId,
    int mealId,
    int utcOffsetMinutes,
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
        where: (t) =>
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
      final result = stats.feed(
        pet,
        meal,
        now,
        utcOffsetMinutes: utcOffsetMinutes,
      );

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

  Future<NutritionInsights> insights(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    final since = DateTime.now().toUtc().subtract(
      const Duration(days: insightsDays),
    );
    final meals = await Meal.db.find(
      session,
      where: (t) =>
          t.ownerId.equals(ownerId) &
          t.fed.equals(true) &
          (t.createdAt > since),
    );
    return buildInsights(
      petName: pet.name,
      meals: meals,
      utcOffsetMinutes: pet.utcOffsetMinutes,
    );
  }

  bool _isJpeg(Uint8List bytes) =>
      bytes.length > 3 && bytes[0] == 0xFF && bytes[1] == 0xD8;
}

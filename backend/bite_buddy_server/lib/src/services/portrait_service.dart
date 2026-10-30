import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/portrait_rules.dart';
import 'nutrition_ai_service.dart';
import 'pet_service.dart';
import 'portrait/portrait_generator.dart';

// "Use my own pet": the user's photo is checked by the AI (a real animal, no
// people), redrawn as a buddy, shown as a draft, and then put on their pet.
class PortraitService {
  final NutritionAiService ai;
  final PetService pets;
  final PortraitGenerator generator;

  const PortraitService({
    required this.ai,
    required this.pets,
    this.generator = const StubPortraitGenerator(),
  });

  Future<PortraitDraft> create(
    Session session,
    UuidValue ownerId,
    ByteData image,
  ) async {
    final bytes = image.buffer.asUint8List(
      image.offsetInBytes,
      image.lengthInBytes,
    );
    if (bytes.length > maxPortraitPhotoBytes) {
      throw invalidInputError('That photo is too big. Try a smaller one.');
    }
    final mimeType = photoMimeType(bytes);
    if (bytes.length < minPortraitPhotoBytes || mimeType == null) {
      throw invalidInputError('Please use a JPEG or PNG photo of your pet.');
    }

    final now = DateTime.now().toUtc();
    final dayAgo = now.subtract(const Duration(days: 1));
    final madeToday = await PetPortrait.db.count(
      session,
      where: (t) => t.ownerId.equals(ownerId) & (t.createdAt > dayAgo),
    );
    if (madeToday >= maxPortraitsPerDay) {
      throw conflictError(
        'TOO_MANY_PORTRAITS',
        "That's $maxPortraitsPerDay pictures today. Try again tomorrow!",
      );
    }

    final Map<String, dynamic> answer;
    try {
      answer = await ai.generateJson(
        session,
        system: portraitCheckSystemPrompt,
        prompt: portraitCheckPrompt,
        schema: portraitCheckSchema,
        photo: bytes,
        photoMimeType: mimeType,
      );
    } on BiteBuddyException catch (e) {
      // The shared AI errors talk about food scans; say it about pictures
      throw e.code == 'MEAL_REJECTED'
          ? conflictError(
              'PORTRAIT_REJECTED',
              "We couldn't use this photo. Try another picture of your pet.",
            )
          : conflictError(
              'AI_UNAVAILABLE',
              'The picture maker is busy right now. Please try again.',
            );
    }
    final check = readPortraitCheck(answer);
    final animal = check.animal;
    if (animal == null) {
      throw conflictError('PORTRAIT_REJECTED', check.reason);
    }

    final picture = await generator.redraw(session, bytes, animal);
    // Unused drafts from earlier days are no longer needed
    await PetPortrait.db.deleteWhere(
      session,
      where: (t) =>
          t.ownerId.equals(ownerId) &
          t.used.equals(false) &
          (t.createdAt < dayAgo),
    );
    final saved = await PetPortrait.db.insertRow(
      session,
      PetPortrait(
        ownerId: ownerId,
        image: ByteData.sublistView(picture),
        animal: animal,
        used: false,
        createdAt: now,
      ),
    );
    return PortraitDraft(
      id: saved.id!,
      image: saved.image,
      animal: animal,
      triesLeftToday: maxPortraitsPerDay - madeToday - 1,
    );
  }

  // Puts one of the owner's portraits on their pet
  Future<Pet> apply(Session session, UuidValue ownerId, int portraitId) async {
    final portrait = await PetPortrait.db.findById(session, portraitId);
    if (portrait == null || portrait.ownerId != ownerId) {
      throw notFoundError('Picture');
    }
    final pet = await pets.requireMine(session, ownerId);
    if (!portrait.used) {
      await PetPortrait.db.updateRow(session, portrait.copyWith(used: true));
    }
    return Pet.db.updateRow(session, pet.copyWith(portraitId: portraitId));
  }

  // Back to the species picture
  Future<Pet> clear(Session session, UuidValue ownerId) async {
    final pet = await pets.requireMine(session, ownerId);
    return Pet.db.updateRow(session, pet..portraitId = null);
  }

  // Anyone signed in can see a portrait that's in use (friends see each
  // other's buddies); drafts only by their owner
  Future<ByteData> image(
    Session session,
    UuidValue userId,
    int portraitId,
  ) async {
    final portrait = await PetPortrait.db.findById(session, portraitId);
    if (portrait == null || (!portrait.used && portrait.ownerId != userId)) {
      throw notFoundError('Picture');
    }
    return portrait.image;
  }
}

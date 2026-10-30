import 'dart:math';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/catalog.dart';
import '../utils/portrait_rules.dart';
import 'nutrition_ai_service.dart';
import 'pet_service.dart';
import 'portrait/portrait_generator.dart';

// "My own pet", the fifth choice when picking a buddy: the user's photo is
// checked by the AI (a real animal, no people), redrawn as a buddy, shown as
// a draft, and then adopted with a species picked at random for its powers.
class PortraitService {
  final NutritionAiService ai;
  final PetService pets;
  final PortraitGenerator generator;
  final Random _rng;

  PortraitService({
    required this.ai,
    required this.pets,
    this.generator = const StubPortraitGenerator(),
    Random? rng,
  }) : _rng = rng ?? Random();

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

    if (await pets.findMine(session, ownerId) != null) {
      throw conflictError('PET_EXISTS', 'You already have a pet.');
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

  // Adopts a pet that looks like the user's own, with a species (which only
  // decides its name tag and powers, never the picture) picked for them
  Future<Pet> adopt(
    Session session,
    UuidValue ownerId,
    int portraitId,
    String name,
  ) async {
    final portrait = await PetPortrait.db.findById(session, portraitId);
    if (portrait == null || portrait.ownerId != ownerId) {
      throw notFoundError('Picture');
    }
    final species = petSpecies[_rng.nextInt(petSpecies.length)];
    final pet = await pets.adopt(
      session,
      ownerId,
      species.key,
      name,
      portraitId: portraitId,
    );
    await PetPortrait.db.updateRow(session, portrait.copyWith(used: true));
    return pet;
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

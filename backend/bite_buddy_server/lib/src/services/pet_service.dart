import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/catalog.dart';
import '../utils/codes.dart';
import '../utils/pet_stats.dart';

class PetService {
  const PetService();

  // The user's pet with neglect decay and its streak brought up to date, or
  // null if they haven't adopted one.
  Future<Pet?> findMine(
    Session session,
    UuidValue ownerId, {
    Transaction? transaction,
  }) async {
    final pet = await Pet.db.findFirstRow(
      session,
      where: (t) => t.ownerId.equals(ownerId),
      transaction: transaction,
    );
    if (pet == null) return null;

    final now = DateTime.now().toUtc();
    var updated = expireStreak(applyDecay(pet, now), now);
    // Pets adopted before friends existed get their code the first time
    // they're loaded
    if (pet.friendCode == null) {
      updated = updated.copyWith(
        friendCode: await _unusedFriendCode(session, transaction),
      );
    }
    if (updated.lastDecayAt == pet.lastDecayAt &&
        updated.streak == pet.streak &&
        updated.friendCode == pet.friendCode) {
      return pet;
    }
    return Pet.db.updateRow(session, updated, transaction: transaction);
  }

  Future<Pet> requireMine(
    Session session,
    UuidValue ownerId, {
    Transaction? transaction,
  }) async {
    final pet = await findMine(session, ownerId, transaction: transaction);
    if (pet == null) throw noPetError();
    return pet;
  }

  Future<Pet> adopt(
    Session session,
    UuidValue ownerId,
    String speciesKey,
    String name,
  ) async {
    if (findSpecies(speciesKey) == null) {
      throw invalidInputError('Unknown pet species.');
    }
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > 20) {
      throw invalidInputError('Pet names must be 1 to 20 characters.');
    }

    final existing = await Pet.db.findFirstRow(
      session,
      where: (t) => t.ownerId.equals(ownerId),
    );
    if (existing != null) {
      throw conflictError('PET_EXISTS', 'You already have a pet.');
    }

    final pet = newPet(
      ownerId: ownerId,
      speciesKey: speciesKey,
      name: trimmed,
      now: DateTime.now().toUtc(),
    );
    return Pet.db.insertRow(
      session,
      pet.copyWith(friendCode: await _unusedFriendCode(session, null)),
    );
  }

  // With ~900 million possible codes a clash is very unlikely, but cheap to
  // rule out
  Future<String> _unusedFriendCode(
    Session session,
    Transaction? transaction,
  ) async {
    while (true) {
      final code = newCode();
      final taken = await Pet.db.count(
        session,
        where: (t) => t.friendCode.equals(code),
        transaction: transaction,
      );
      if (taken == 0) return code;
    }
  }
}

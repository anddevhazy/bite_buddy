import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/catalog.dart';
import '../utils/pet_stats.dart';

class PetService {
  const PetService();

  // The user's pet with neglect decay brought up to date, or null if they
  // haven't adopted one.
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

    final decayed = applyDecay(pet, DateTime.now().toUtc());
    if (decayed.lastDecayAt == pet.lastDecayAt) return pet;
    return Pet.db.updateRow(session, decayed, transaction: transaction);
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

    return Pet.db.insertRow(
      session,
      newPet(
        ownerId: ownerId,
        speciesKey: speciesKey,
        name: trimmed,
        now: DateTime.now().toUtc(),
      ),
    );
  }
}

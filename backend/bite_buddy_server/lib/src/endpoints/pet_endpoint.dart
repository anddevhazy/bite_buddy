import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/catalog.dart';
import '../utils/session_user.dart';

// client.pet
class PetEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<PetSpecies>> listSpecies(Session session) async =>
      [for (final s in petSpecies) s.toProtocol()];

  // Null until the user adopts a pet
  Future<Pet?> getMyPet(Session session) =>
      petService.findMine(session, session.userId);

  Future<Pet> adopt(Session session, String speciesKey, String name) =>
      petService.adopt(session, session.userId, speciesKey, name);
}

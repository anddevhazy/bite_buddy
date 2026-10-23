import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class LeaderboardService {
  const LeaderboardService();

  static const int size = 50;

  // Top pets by nutrition. Pets that never ate are left out so the board
  // isn't padded with zeros.
  Future<List<LeaderboardEntry>> top(Session session, UuidValue callerId) async {
    final pets = await Pet.db.find(
      session,
      where: (t) => t.mealsEaten > 0,
      orderBy: (t) => t.nutrition,
      orderDescending: true,
      limit: size,
    );

    return [
      for (final (i, pet) in pets.indexed)
        LeaderboardEntry(
          rank: i + 1,
          petId: pet.id!,
          petName: pet.name,
          speciesKey: pet.speciesKey,
          level: pet.level,
          nutrition: pet.nutrition,
          isYou: pet.ownerId == callerId,
        ),
    ];
  }
}

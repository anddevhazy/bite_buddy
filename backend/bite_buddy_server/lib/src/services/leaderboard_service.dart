import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../utils/leaderboard.dart';

class LeaderboardService {
  const LeaderboardService();

  static const int size = 50;

  // Top pets by nutrition, plus the caller's own pet if it ranks lower. Pets
  // that never ate are left out so the board isn't padded with zeros.
  //
  // Every pet that has eaten is loaded so hunger decay can be applied before
  // ranking (see rankLeaderboard). Fine for thousands of players; past that,
  // move the decay into the query or save it on a schedule.
  Future<List<LeaderboardEntry>> top(
    Session session,
    UuidValue callerId,
  ) async {
    final pets = await Pet.db.find(
      session,
      where: (t) => t.mealsEaten > 0,
    );
    return rankLeaderboard(
      pets,
      callerId,
      DateTime.now().toUtc(),
      size: size,
    );
  }
}

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.leaderboard
class LeaderboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<LeaderboardEntry>> top(Session session) =>
      leaderboardService.top(session, session.userId);
}

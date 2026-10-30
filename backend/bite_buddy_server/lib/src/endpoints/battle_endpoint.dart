import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.battle: real-time fights against computer opponents
class BattleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // The pet's battle stats and every opponent with its fighting style
  Future<Arena> arena(Session session) =>
      battleService.arena(session, session.userId);

  // Sets up a fight; the phone plays it and reports back with finishRun
  Future<ArenaRunConfig> startRun(Session session, String opponentKey) =>
      battleService.startRun(session, session.userId, opponentKey);

  Future<ArenaRunResult> finishRun(
    Session session,
    int runId,
    ArenaRunReport report,
  ) => battleService.finishRun(session, session.userId, runId, report);
}

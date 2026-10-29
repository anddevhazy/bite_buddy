import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.battle
class BattleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // The pet's battle stats and every opponent, with win chances
  Future<Arena> arena(Session session) =>
      battleService.arena(session, session.userId);

  Future<BattleState> start(Session session, String opponentKey) =>
      battleService.start(session, session.userId, opponentKey);

  Future<BattleState> move(Session session, int battleId, BattleMove move) =>
      battleService.move(session, session.userId, battleId, move);
}

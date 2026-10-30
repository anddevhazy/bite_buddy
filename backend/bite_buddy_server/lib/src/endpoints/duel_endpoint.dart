import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.duel: async turn-based battles between league friends
class DuelEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<DuelView> challenge(
    Session session,
    int leagueId,
    int opponentMemberId,
  ) => duelService.challenge(
    session,
    session.userId,
    leagueId,
    opponentMemberId,
  );

  Future<DuelView> get(Session session, int duelId) =>
      duelService.get(session, session.userId, duelId);

  Future<DuelView> move(Session session, int duelId, BattleMove move) =>
      duelService.move(session, session.userId, duelId, move);
}

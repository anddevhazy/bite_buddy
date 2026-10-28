import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.challenge
class ChallengeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<ChallengeSummary> create(Session session, String name, int days) =>
      challengeService.create(session, session.userId, name, days);

  Future<ChallengeSummary> join(Session session, String code) =>
      challengeService.join(session, session.userId, code);

  Future<List<ChallengeSummary>> mine(Session session) =>
      challengeService.mine(session, session.userId);

  Future<ChallengeSummary> get(Session session, int challengeId) =>
      challengeService.get(session, session.userId, challengeId);

  Future<void> leave(Session session, int challengeId) =>
      challengeService.leave(session, session.userId, challengeId);
}

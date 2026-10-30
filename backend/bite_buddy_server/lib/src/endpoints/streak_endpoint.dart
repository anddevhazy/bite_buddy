import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.streak: shared streaks with league friends
class StreakEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<StreakBuddyView>> mine(Session session) =>
      streakService.mine(session, session.userId);

  // League friends you could invite
  Future<List<StreakFriend>> candidates(Session session) =>
      streakService.candidates(session, session.userId);

  Future<StreakBuddyView> invite(Session session, UuidValue friendUserId) =>
      streakService.invite(session, session.userId, friendUserId);

  Future<StreakBuddyView> accept(Session session, int streakId) =>
      streakService.accept(session, session.userId, streakId);

  // Declines, cancels or ends a shared streak
  Future<void> remove(Session session, int streakId) =>
      streakService.remove(session, session.userId, streakId);
}

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.league: friend leagues and their weekly seasons
class LeagueEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<LeagueSummary>> myLeagues(Session session) =>
      leagueService.myLeagues(session, session.userId);

  Future<LeagueDetail> create(Session session, String name) =>
      leagueService.create(session, session.userId, name);

  Future<LeagueDetail> join(Session session, String inviteCode) =>
      leagueService.join(session, session.userId, inviteCode);

  Future<LeagueDetail> detail(Session session, int leagueId) =>
      leagueService.detail(session, session.userId, leagueId);

  Future<void> leave(Session session, int leagueId) =>
      leagueService.leave(session, session.userId, leagueId);

  Future<List<Trophy>> trophies(Session session) =>
      leagueService.trophies(session, session.userId);
}

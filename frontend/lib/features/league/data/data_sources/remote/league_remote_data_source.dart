import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';

abstract class LeagueRemoteDataSource {
  Future<List<LeagueSummaryEntity>> fetchMyLeagues();
  Future<LeagueDetailEntity> createLeague(String name);
  Future<LeagueDetailEntity> joinLeague(String inviteCode);
  Future<LeagueDetailEntity> fetchLeague(int leagueId);
  Future<void> leaveLeague(int leagueId);
  Future<List<TrophyEntity>> fetchTrophies();
  Future<DuelEntity> challenge(int leagueId, int memberId);
  Future<DuelEntity> fetchDuel(int duelId);
  Future<DuelEntity> playDuelMove(int duelId, BattleMove move);
}

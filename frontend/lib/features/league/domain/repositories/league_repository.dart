import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:dartz/dartz.dart';

abstract class LeagueRepository {
  Future<Either<Failure, List<LeagueSummaryEntity>>> fetchMyLeagues();
  Future<Either<Failure, LeagueDetailEntity>> createLeague(String name);
  Future<Either<Failure, LeagueDetailEntity>> joinLeague(String inviteCode);
  Future<Either<Failure, LeagueDetailEntity>> fetchLeague(int leagueId);
  Future<Either<Failure, void>> leaveLeague(int leagueId);
  Future<Either<Failure, List<TrophyEntity>>> fetchTrophies();

  Future<Either<Failure, DuelEntity>> challenge(int leagueId, int memberId);
  Future<Either<Failure, DuelEntity>> fetchDuel(int duelId);
  Future<Either<Failure, DuelEntity>> playDuelMove(int duelId, BattleMove move);
}

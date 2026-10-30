import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/league/data/data_sources/remote/league_remote_data_source.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueRemoteDataSource remoteDataSource;

  LeagueRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LeagueSummaryEntity>>> fetchMyLeagues() async {
    try {
      return Right(await remoteDataSource.fetchMyLeagues());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, LeagueDetailEntity>> createLeague(String name) async {
    try {
      return Right(await remoteDataSource.createLeague(name));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, LeagueDetailEntity>> joinLeague(
    String inviteCode,
  ) async {
    try {
      return Right(await remoteDataSource.joinLeague(inviteCode));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, LeagueDetailEntity>> fetchLeague(int leagueId) async {
    try {
      return Right(await remoteDataSource.fetchLeague(leagueId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> leaveLeague(int leagueId) async {
    try {
      await remoteDataSource.leaveLeague(leagueId);
      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<TrophyEntity>>> fetchTrophies() async {
    try {
      return Right(await remoteDataSource.fetchTrophies());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, DuelEntity>> challenge(
    int leagueId,
    int memberId,
  ) async {
    try {
      return Right(await remoteDataSource.challenge(leagueId, memberId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, DuelEntity>> fetchDuel(int duelId) async {
    try {
      return Right(await remoteDataSource.fetchDuel(duelId));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, DuelEntity>> playDuelMove(
    int duelId,
    BattleMove move,
  ) async {
    try {
      return Right(await remoteDataSource.playDuelMove(duelId, move));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class BattleRepositoryImpl implements BattleRepository {
  final BattleRemoteDataSource remoteDataSource;

  BattleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ArenaEntity>> fetchArena() async {
    try {
      return Right(await remoteDataSource.fetchArena());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ArenaRunConfigEntity>> startRun(
    String opponentKey,
  ) async {
    try {
      return Right(await remoteDataSource.startRun(opponentKey));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ArenaRunResultEntity>> finishRun(
    int runId,
    ArenaRunReportEntity report,
  ) async {
    try {
      return Right(await remoteDataSource.finishRun(runId, report));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

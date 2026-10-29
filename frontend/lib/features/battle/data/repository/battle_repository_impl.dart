import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
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
  Future<Either<Failure, BattleEntity>> startBattle(String opponentKey) async {
    try {
      return Right(await remoteDataSource.startBattle(opponentKey));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, BattleEntity>> playMove(
    int battleId,
    BattleMove move,
  ) async {
    try {
      return Right(await remoteDataSource.playMove(battleId, move));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

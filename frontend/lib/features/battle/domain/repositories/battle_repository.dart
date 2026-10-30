import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class BattleRepository {
  Future<Either<Failure, ArenaEntity>> fetchArena();

  Future<Either<Failure, ArenaRunConfigEntity>> startRun(String opponentKey);

  Future<Either<Failure, ArenaRunResultEntity>> finishRun(
    int runId,
    ArenaRunReportEntity report,
  );
}

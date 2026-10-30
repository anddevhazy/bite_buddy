import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class FinishRunUseCase {
  final BattleRepository repository;

  FinishRunUseCase({required this.repository});

  Future<Either<Failure, ArenaRunResultEntity>> call(
    int runId,
    ArenaRunReportEntity report,
  ) => repository.finishRun(runId, report);
}

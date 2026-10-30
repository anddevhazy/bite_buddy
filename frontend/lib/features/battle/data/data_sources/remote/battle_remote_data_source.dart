import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';

abstract class BattleRemoteDataSource {
  Future<ArenaEntity> fetchArena();
  Future<ArenaRunConfigEntity> startRun(String opponentKey);
  Future<ArenaRunResultEntity> finishRun(
    int runId,
    ArenaRunReportEntity report,
  );
}

import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/data/models/arena_model.dart';
import 'package:bite_buddy/features/battle/data/models/arena_run_models.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class BattleRemoteDataSourceImpl implements BattleRemoteDataSource {
  final Client client;

  BattleRemoteDataSourceImpl({required this.client});

  @override
  Future<ArenaEntity> fetchArena() async =>
      ArenaModel.fromProtocol(await client.battle.arena());

  @override
  Future<ArenaRunConfigEntity> startRun(String opponentKey) async =>
      ArenaRunModels.config(await client.battle.startRun(opponentKey));

  @override
  Future<ArenaRunResultEntity> finishRun(
    int runId,
    ArenaRunReportEntity report,
  ) async => ArenaRunModels.result(
    await client.battle.finishRun(runId, ArenaRunModels.report(report)),
  );
}

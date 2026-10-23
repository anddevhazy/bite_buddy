import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/data/models/battle_model.dart';
import 'package:bite_buddy/features/battle/data/models/opponent_model.dart';
import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart' as app;
import 'package:bite_buddy_client/bite_buddy_client.dart';

class BattleRemoteDataSourceImpl implements BattleRemoteDataSource {
  final Client client;

  BattleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OpponentEntity>> fetchOpponents() async {
    final opponents = await client.battle.opponents();
    return opponents.map(OpponentModel.fromProtocol).toList();
  }

  @override
  Future<BattleEntity> startBattle(String opponentKey) async {
    final state = await client.battle.start(opponentKey);
    return BattleModel.fromProtocol(state);
  }

  @override
  Future<BattleEntity> playMove(int battleId, app.BattleMove move) async {
    final state = await client.battle.move(
      battleId,
      BattleModel.toProtocolMove(move),
    );
    return BattleModel.fromProtocol(state);
  }
}

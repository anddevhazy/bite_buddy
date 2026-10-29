import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';

abstract class BattleRemoteDataSource {
  Future<ArenaEntity> fetchArena();
  Future<BattleEntity> startBattle(String opponentKey);
  Future<BattleEntity> playMove(int battleId, BattleMove move);
}

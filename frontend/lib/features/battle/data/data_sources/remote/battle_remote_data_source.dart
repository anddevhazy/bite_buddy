import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';

abstract class BattleRemoteDataSource {
  Future<List<OpponentEntity>> fetchOpponents();
  Future<BattleEntity> startBattle(String opponentKey);
  Future<BattleEntity> playMove(int battleId, BattleMove move);
}

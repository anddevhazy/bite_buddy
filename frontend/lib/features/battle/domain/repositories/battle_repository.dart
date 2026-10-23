import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:dartz/dartz.dart';

abstract class BattleRepository {
  Future<Either<Failure, List<OpponentEntity>>> fetchOpponents();

  Future<Either<Failure, BattleEntity>> startBattle(String opponentKey);

  Future<Either<Failure, BattleEntity>> playMove(int battleId, BattleMove move);
}

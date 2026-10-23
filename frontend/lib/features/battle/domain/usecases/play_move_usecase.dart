import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:dartz/dartz.dart';

class PlayMoveUseCase {
  final BattleRepository repository;

  PlayMoveUseCase({required this.repository});

  Future<Either<Failure, BattleEntity>> call(int battleId, BattleMove move) =>
      repository.playMove(battleId, move);
}

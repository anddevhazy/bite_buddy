import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class StartBattleUseCase {
  final BattleRepository repository;

  StartBattleUseCase({required this.repository});

  Future<Either<Failure, BattleEntity>> call(String opponentKey) =>
      repository.startBattle(opponentKey);
}

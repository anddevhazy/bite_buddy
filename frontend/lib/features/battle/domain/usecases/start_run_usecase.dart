import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class StartRunUseCase {
  final BattleRepository repository;

  StartRunUseCase({required this.repository});

  Future<Either<Failure, ArenaRunConfigEntity>> call(String opponentKey) =>
      repository.startRun(opponentKey);
}

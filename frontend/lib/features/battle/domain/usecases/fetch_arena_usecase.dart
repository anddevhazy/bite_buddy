import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class FetchArenaUseCase {
  final BattleRepository repository;

  FetchArenaUseCase({required this.repository});

  Future<Either<Failure, ArenaEntity>> call() => repository.fetchArena();
}

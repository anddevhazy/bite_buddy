import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class FetchOpponentsUseCase {
  final BattleRepository repository;

  FetchOpponentsUseCase({required this.repository});

  Future<Either<Failure, List<OpponentEntity>>> call() =>
      repository.fetchOpponents();
}

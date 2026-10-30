import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy/features/keepsakes/domain/repositories/keepsake_repository.dart';
import 'package:dartz/dartz.dart';

class MintKeepsakeUseCase {
  final KeepsakeRepository repository;

  MintKeepsakeUseCase({required this.repository});

  Future<Either<Failure, KeepsakeEntity>> call(String key) =>
      repository.mint(key);
}

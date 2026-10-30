import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:dartz/dartz.dart';

class ClearPortraitUseCase {
  final PortraitRepository repository;

  ClearPortraitUseCase({required this.repository});

  Future<Either<Failure, PetEntity>> call() => repository.clear();
}

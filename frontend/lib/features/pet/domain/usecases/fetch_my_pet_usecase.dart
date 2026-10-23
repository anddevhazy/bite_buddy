import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';

class FetchMyPetUseCase {
  final PetRepository repository;

  FetchMyPetUseCase({required this.repository});

  Future<Either<Failure, PetEntity?>> call() => repository.fetchMyPet();
}

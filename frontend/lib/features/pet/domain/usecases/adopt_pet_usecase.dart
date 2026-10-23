import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';

class AdoptPetUseCase {
  final PetRepository repository;

  AdoptPetUseCase({required this.repository});

  Future<Either<Failure, PetEntity>> call(String speciesKey, String name) =>
      repository.adoptPet(speciesKey, name);
}

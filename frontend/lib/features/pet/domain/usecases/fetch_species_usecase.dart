import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:dartz/dartz.dart';

class FetchSpeciesUseCase {
  final PetRepository repository;

  FetchSpeciesUseCase({required this.repository});

  Future<Either<Failure, List<PetSpeciesEntity>>> call() =>
      repository.fetchSpecies();
}

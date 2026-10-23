import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PetRepository {
  Future<Either<Failure, List<PetSpeciesEntity>>> fetchSpecies();

  // Right(null) means the user hasn't adopted a pet yet
  Future<Either<Failure, PetEntity?>> fetchMyPet();

  Future<Either<Failure, PetEntity>> adoptPet(String speciesKey, String name);
}

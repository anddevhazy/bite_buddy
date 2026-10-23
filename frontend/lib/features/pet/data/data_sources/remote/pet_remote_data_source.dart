import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';

abstract class PetRemoteDataSource {
  Future<List<PetSpeciesEntity>> fetchSpecies();
  Future<PetEntity?> fetchMyPet();
  Future<PetEntity> adoptPet(String speciesKey, String name);
}

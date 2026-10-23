import 'package:bite_buddy/features/pet/data/data_sources/remote/pet_remote_data_source.dart';
import 'package:bite_buddy/features/pet/data/models/pet_model.dart';
import 'package:bite_buddy/features/pet/data/models/pet_species_model.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  final Client client;

  PetRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PetSpeciesEntity>> fetchSpecies() async {
    final species = await client.pet.listSpecies();
    return species.map(PetSpeciesModel.fromProtocol).toList();
  }

  @override
  Future<PetEntity?> fetchMyPet() async {
    final pet = await client.pet.getMyPet();
    return pet == null ? null : PetModel.fromProtocol(pet);
  }

  @override
  Future<PetEntity> adoptPet(String speciesKey, String name) async {
    final pet = await client.pet.adopt(speciesKey, name);
    return PetModel.fromProtocol(pet);
  }
}

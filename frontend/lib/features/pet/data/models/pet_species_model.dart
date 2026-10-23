import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class PetSpeciesModel extends PetSpeciesEntity {
  const PetSpeciesModel({
    required super.key,
    required super.name,
    required super.title,
    required super.rarity,
    required super.emoji,
  });

  factory PetSpeciesModel.fromProtocol(PetSpecies species) {
    return PetSpeciesModel(
      key: species.key,
      name: species.name,
      title: species.title,
      rarity: species.rarity,
      emoji: species.emoji,
    );
  }
}

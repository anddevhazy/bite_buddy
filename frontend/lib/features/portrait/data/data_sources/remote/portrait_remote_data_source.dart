import 'dart:typed_data';

import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';

abstract class PortraitRemoteDataSource {
  Future<PortraitDraftEntity> create(Uint8List photo);

  Future<PetEntity> apply(int portraitId);

  Future<PetEntity> clear();
}

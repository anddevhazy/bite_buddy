import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PortraitRepository {
  Future<Either<Failure, PortraitDraftEntity>> create(Uint8List photo);

  // Adopts a buddy that looks like the user's pet; the server picks its
  // species
  Future<Either<Failure, PetEntity>> adopt(int portraitId, String name);
}

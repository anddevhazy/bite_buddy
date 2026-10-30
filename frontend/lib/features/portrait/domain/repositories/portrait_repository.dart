import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PortraitRepository {
  Future<Either<Failure, PortraitDraftEntity>> create(Uint8List photo);

  Future<Either<Failure, PetEntity>> apply(int portraitId);

  // Back to the species picture
  Future<Either<Failure, PetEntity>> clear();
}

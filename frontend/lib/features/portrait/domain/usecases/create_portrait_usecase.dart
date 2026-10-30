import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePortraitUseCase {
  final PortraitRepository repository;

  CreatePortraitUseCase({required this.repository});

  Future<Either<Failure, PortraitDraftEntity>> call(Uint8List photo) =>
      repository.create(photo);
}

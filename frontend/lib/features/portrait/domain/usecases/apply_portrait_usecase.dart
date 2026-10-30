import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:dartz/dartz.dart';

class ApplyPortraitUseCase {
  final PortraitRepository repository;

  ApplyPortraitUseCase({required this.repository});

  Future<Either<Failure, PetEntity>> call(int portraitId) =>
      repository.apply(portraitId);
}

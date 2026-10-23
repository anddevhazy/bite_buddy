import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:dartz/dartz.dart';

class AnalyzeMealUseCase {
  final ScannerRepository repository;

  AnalyzeMealUseCase({required this.repository});

  Future<Either<Failure, MealEntity>> call(Uint8List jpegBytes) =>
      repository.analyzeMeal(jpegBytes);
}

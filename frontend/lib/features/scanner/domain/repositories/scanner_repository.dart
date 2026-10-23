import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ScannerRepository {
  // Left(MealRejectedFailure) when the photo isn't a real, live meal
  Future<Either<Failure, MealEntity>> analyzeMeal(Uint8List jpegBytes);

  Future<Either<Failure, FeedResultEntity>> feedPet(int mealId);
}

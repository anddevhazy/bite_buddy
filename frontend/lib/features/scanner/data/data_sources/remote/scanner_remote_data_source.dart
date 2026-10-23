import 'dart:typed_data';

import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';

abstract class ScannerRemoteDataSource {
  Future<MealEntity> analyzeMeal(Uint8List jpegBytes);
  Future<FeedResultEntity> feedPet(int mealId);
}

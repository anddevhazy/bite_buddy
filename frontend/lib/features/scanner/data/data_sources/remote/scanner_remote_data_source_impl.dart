import 'dart:typed_data';

import 'package:bite_buddy/features/scanner/data/data_sources/remote/scanner_remote_data_source.dart';
import 'package:bite_buddy/features/scanner/data/models/feed_result_model.dart';
import 'package:bite_buddy/features/scanner/data/models/meal_model.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class ScannerRemoteDataSourceImpl implements ScannerRemoteDataSource {
  final Client client;

  ScannerRemoteDataSourceImpl({required this.client});

  @override
  Future<MealEntity> analyzeMeal(Uint8List jpegBytes) async {
    final meal = await client.meal.analyze(ByteData.sublistView(jpegBytes));
    return MealModel.fromProtocol(meal);
  }

  @override
  Future<FeedResultEntity> feedPet(int mealId) async {
    // The server counts streak days in the phone's time zone
    final result = await client.meal.feed(
      mealId,
      DateTime.now().timeZoneOffset.inMinutes,
    );
    return FeedResultModel.fromProtocol(result);
  }
}

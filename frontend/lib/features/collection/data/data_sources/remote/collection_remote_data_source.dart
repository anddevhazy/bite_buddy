import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';

abstract class CollectionRemoteDataSource {
  Future<List<LeaderboardEntryEntity>> fetchLeaderboard();
  Future<List<MealEntity>> fetchMealHistory();
}

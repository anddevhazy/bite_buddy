import 'package:bite_buddy/features/collection/data/data_sources/remote/collection_remote_data_source.dart';
import 'package:bite_buddy/features/collection/data/models/leaderboard_entry_model.dart';
import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/scanner/data/models/meal_model.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final Client client;

  CollectionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeaderboardEntryEntity>> fetchLeaderboard() async {
    final entries = await client.leaderboard.top();
    return entries.map(LeaderboardEntryModel.fromProtocol).toList();
  }

  @override
  Future<List<MealEntity>> fetchMealHistory() async {
    final meals = await client.meal.history();
    return meals.map(MealModel.fromProtocol).toList();
  }
}

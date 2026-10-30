import 'package:bite_buddy/features/insights/data/data_sources/remote/insights_remote_data_source.dart';
import 'package:bite_buddy/features/insights/data/models/nutrition_insights_model.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:intl/intl.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class InsightsRemoteDataSourceImpl implements InsightsRemoteDataSource {
  final Client client;

  InsightsRemoteDataSourceImpl({required this.client});

  @override
  Future<NutritionInsightsEntity> fetchInsights() async {
    final insights = await client.meal.insights();
    return NutritionInsightsModel.fromProtocol(insights);
  }

  @override
  Future<List<MealIdeaEntity>> fetchMealIdeas() async {
    // The phone's locale (e.g. en_NG) lets the AI suggest local food
    final ideas = await client.meal.ideas(Intl.getCurrentLocale());
    return [
      for (final i in ideas)
        MealIdeaEntity(name: i.name, reason: i.reason, boosts: i.boosts),
    ];
  }
}

import 'package:bite_buddy/features/insights/data/data_sources/remote/insights_remote_data_source.dart';
import 'package:bite_buddy/features/insights/data/models/nutrition_insights_model.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class InsightsRemoteDataSourceImpl implements InsightsRemoteDataSource {
  final Client client;

  InsightsRemoteDataSourceImpl({required this.client});

  @override
  Future<NutritionInsightsEntity> fetchInsights() async {
    final insights = await client.meal.insights();
    return NutritionInsightsModel.fromProtocol(insights);
  }
}

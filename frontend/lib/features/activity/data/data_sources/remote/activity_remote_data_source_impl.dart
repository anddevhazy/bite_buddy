import 'package:bite_buddy/features/activity/data/data_sources/remote/activity_remote_data_source.dart';
import 'package:bite_buddy/features/activity/data/models/activity_sync_model.dart';
import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final Client client;

  ActivityRemoteDataSourceImpl({required this.client});

  @override
  Future<ActivitySyncEntity> sync({
    required int steps,
    required int sleepMinutes,
  }) async {
    final result = await client.activity.sync(
      steps,
      sleepMinutes,
      DateTime.now().timeZoneOffset.inMinutes,
    );
    return ActivitySyncModel.fromProtocol(result);
  }
}

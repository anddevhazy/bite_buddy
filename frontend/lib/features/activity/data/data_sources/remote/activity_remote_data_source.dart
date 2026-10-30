import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';

abstract class ActivityRemoteDataSource {
  Future<ActivitySyncEntity> sync({
    required int steps,
    required int sleepMinutes,
  });
}

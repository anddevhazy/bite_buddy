import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.activity: steps and sleep from Apple Health or Health Connect
class ActivityEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // [steps] so far today and [sleepMinutes] last night, from the phone's
  // health app. utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes
  Future<ActivitySyncResult> sync(
    Session session,
    int steps,
    int sleepMinutes,
    int utcOffsetMinutes,
  ) => activityService.sync(
    session,
    session.userId,
    steps: steps,
    sleepMinutes: sleepMinutes,
    utcOffsetMinutes: utcOffsetMinutes,
  );
}

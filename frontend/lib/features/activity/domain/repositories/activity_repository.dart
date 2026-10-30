import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ActivityRepository {
  HealthSource get source;

  // Whether the user has connected their health app before
  Future<bool> isConnected();

  // Asks for access to steps and sleep. Left when the user says no or the
  // health app is missing.
  Future<Either<Failure, Unit>> connect();

  Future<void> disconnect();

  // Reads today's numbers from the health app and sends them to the server
  Future<Either<Failure, ActivitySyncEntity>> sync();
}

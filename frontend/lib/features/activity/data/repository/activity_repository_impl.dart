import 'dart:io';

import 'package:bite_buddy/features/activity/data/data_sources/local/health_data_source.dart';
import 'package:bite_buddy/features/activity/data/data_sources/remote/activity_remote_data_source.dart';
import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/activity/domain/repositories/activity_repository.dart';
import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final HealthDataSource healthDataSource;
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({
    required this.healthDataSource,
    required this.remoteDataSource,
  });

  @override
  HealthSource get source =>
      Platform.isIOS ? HealthSource.appleHealth : HealthSource.healthConnect;

  @override
  Future<bool> isConnected() async {
    try {
      return await healthDataSource.isConnected();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Either<Failure, Unit>> connect() async {
    try {
      final granted = await healthDataSource.connect();
      if (!granted) {
        return const Left(
          HealthFailure(
            'Bite Buddy needs access to steps and sleep to boost your buddy.',
          ),
        );
      }
      return const Right(unit);
    } on HealthUnavailableException catch (e) {
      return Left(HealthFailure(e.message));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  Future<void> disconnect() => healthDataSource.disconnect();

  @override
  Future<Either<Failure, ActivitySyncEntity>> sync() async {
    try {
      final today = await healthDataSource.readToday();
      return Right(
        await remoteDataSource.sync(
          steps: today.steps,
          sleepMinutes: today.sleepMinutes,
        ),
      );
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/activity/domain/repositories/activity_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class SyncActivityUseCase {
  final ActivityRepository repository;

  SyncActivityUseCase({required this.repository});

  Future<Either<Failure, ActivitySyncEntity>> call() => repository.sync();
}

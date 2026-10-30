import 'package:bite_buddy/features/activity/domain/repositories/activity_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class ConnectHealthUseCase {
  final ActivityRepository repository;

  ConnectHealthUseCase({required this.repository});

  Future<Either<Failure, Unit>> call() => repository.connect();
}

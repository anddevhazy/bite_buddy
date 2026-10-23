import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:dartz/dartz.dart';

class FeedPetUseCase {
  final ScannerRepository repository;

  FeedPetUseCase({required this.repository});

  Future<Either<Failure, FeedResultEntity>> call(int mealId) =>
      repository.feedPet(mealId);
}

import 'package:bite_buddy/features/collection/domain/repositories/collection_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:dartz/dartz.dart';

class FetchMealHistoryUseCase {
  final CollectionRepository repository;

  FetchMealHistoryUseCase({required this.repository});

  Future<Either<Failure, List<MealEntity>>> call() =>
      repository.fetchMealHistory();
}

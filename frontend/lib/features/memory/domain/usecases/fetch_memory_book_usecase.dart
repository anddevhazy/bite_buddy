import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy/features/memory/domain/repositories/memory_repository.dart';
import 'package:dartz/dartz.dart';

class FetchMemoryBookUseCase {
  final MemoryRepository repository;

  FetchMemoryBookUseCase({required this.repository});

  Future<Either<Failure, MemoryBookEntity>> call() => repository.fetchBook();
}

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MemoryRepository {
  Future<Either<Failure, MemoryBookEntity>> fetchBook();
}

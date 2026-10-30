import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';

abstract class MemoryRemoteDataSource {
  Future<MemoryBookEntity> fetchBook();
}

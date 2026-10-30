import 'package:bite_buddy/features/memory/data/data_sources/remote/memory_remote_data_source.dart';
import 'package:bite_buddy/features/memory/data/models/memory_book_model.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class MemoryRemoteDataSourceImpl implements MemoryRemoteDataSource {
  final Client client;

  MemoryRemoteDataSourceImpl({required this.client});

  @override
  Future<MemoryBookEntity> fetchBook() async =>
      MemoryBookModel.fromProtocol(await client.memory.book());
}

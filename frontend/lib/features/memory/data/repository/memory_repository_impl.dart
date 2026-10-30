import 'package:bite_buddy/features/global/core/error/failure_mapper.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/memory/data/data_sources/remote/memory_remote_data_source.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy/features/memory/domain/repositories/memory_repository.dart';
import 'package:dartz/dartz.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  final MemoryRemoteDataSource remoteDataSource;

  MemoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MemoryBookEntity>> fetchBook() async {
    try {
      return Right(await remoteDataSource.fetchBook());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}

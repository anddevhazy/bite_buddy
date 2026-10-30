import 'package:bite_buddy/features/memory/data/data_sources/remote/memory_remote_data_source.dart';
import 'package:bite_buddy/features/memory/data/data_sources/remote/memory_remote_data_source_impl.dart';
import 'package:bite_buddy/features/memory/data/repository/memory_repository_impl.dart';
import 'package:bite_buddy/features/memory/domain/repositories/memory_repository.dart';
import 'package:bite_buddy/features/memory/domain/usecases/fetch_memory_book_usecase.dart';
import 'package:bite_buddy/features/memory/presentation/bloc/memory_book_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> memoryInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<MemoryBookCubit>(
    () => MemoryBookCubit(fetchMemoryBookUseCase: sl.call()),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchMemoryBookUseCase>(
    () => FetchMemoryBookUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<MemoryRepository>(
    () => MemoryRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<MemoryRemoteDataSource>(
    () => MemoryRemoteDataSourceImpl(client: sl.call()),
  );
}

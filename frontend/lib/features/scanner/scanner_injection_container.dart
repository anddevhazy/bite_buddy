import 'package:bite_buddy/features/scanner/data/data_sources/remote/scanner_remote_data_source.dart';
import 'package:bite_buddy/features/scanner/data/data_sources/remote/scanner_remote_data_source_impl.dart';
import 'package:bite_buddy/features/scanner/data/repository/scanner_repository_impl.dart';
import 'package:bite_buddy/features/scanner/domain/repositories/scanner_repository.dart';
import 'package:bite_buddy/features/scanner/domain/usecases/analyze_meal_usecase.dart';
import 'package:bite_buddy/features/scanner/domain/usecases/feed_pet_usecase.dart';
import 'package:bite_buddy/features/scanner/presentation/bloc/scanner_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> scannerInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<ScannerCubit>(
    () => ScannerCubit(analyzeMealUseCase: sl.call(), feedPetUseCase: sl.call()),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<AnalyzeMealUseCase>(
    () => AnalyzeMealUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FeedPetUseCase>(
    () => FeedPetUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<ScannerRepository>(
    () => ScannerRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<ScannerRemoteDataSource>(
    () => ScannerRemoteDataSourceImpl(client: sl.call()),
  );
}

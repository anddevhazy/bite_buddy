import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source.dart';
import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source_impl.dart';
import 'package:bite_buddy/features/portrait/data/repository/portrait_repository_impl.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/apply_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/clear_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/create_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/presentation/bloc/portrait_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> portraitInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<PortraitCubit>(
    () => PortraitCubit(
      createPortraitUseCase: sl.call(),
      applyPortraitUseCase: sl.call(),
      clearPortraitUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<CreatePortraitUseCase>(
    () => CreatePortraitUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<ApplyPortraitUseCase>(
    () => ApplyPortraitUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<ClearPortraitUseCase>(
    () => ClearPortraitUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<PortraitRepository>(
    () => PortraitRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<PortraitRemoteDataSource>(
    () => PortraitRemoteDataSourceImpl(client: sl.call(), cache: sl.call()),
  );
}

import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source.dart';
import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source_impl.dart';
import 'package:bite_buddy/features/portrait/data/repository/portrait_repository_impl.dart';
import 'package:bite_buddy/features/portrait/domain/repositories/portrait_repository.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/adopt_with_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/create_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/presentation/bloc/portrait_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> portraitInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<PortraitCubit>(
    () => PortraitCubit(
      createPortraitUseCase: sl.call(),
      adoptWithPortraitUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<CreatePortraitUseCase>(
    () => CreatePortraitUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<AdoptWithPortraitUseCase>(
    () => AdoptWithPortraitUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<PortraitRepository>(
    () => PortraitRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<PortraitRemoteDataSource>(
    () => PortraitRemoteDataSourceImpl(client: sl.call(), cache: sl.call()),
  );
}

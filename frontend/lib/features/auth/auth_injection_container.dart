import 'package:bite_buddy/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:bite_buddy/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:bite_buddy/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bite_buddy/features/auth/domain/repositories/auth_repository.dart';
import 'package:bite_buddy/features/auth/domain/usecases/get_sign_in_status_usecase.dart';
import 'package:bite_buddy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bite_buddy/features/auth/domain/usecases/watch_sign_in_status_usecase.dart';
import 'package:bite_buddy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> authInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      getSignInStatusUseCase: sl.call(),
      watchSignInStatusUseCase: sl.call(),
      signOutUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<GetSignInStatusUseCase>(
    () => GetSignInStatusUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<WatchSignInStatusUseCase>(
    () => WatchSignInStatusUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl.call()),
  );
}

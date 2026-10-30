import 'package:bite_buddy/features/keepsakes/data/data_sources/remote/keepsake_remote_data_source.dart';
import 'package:bite_buddy/features/keepsakes/data/data_sources/remote/keepsake_remote_data_source_impl.dart';
import 'package:bite_buddy/features/keepsakes/data/repository/keepsake_repository_impl.dart';
import 'package:bite_buddy/features/keepsakes/domain/repositories/keepsake_repository.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/create_wallet_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/fetch_keepsakes_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/mint_keepsake_usecase.dart';
import 'package:bite_buddy/features/keepsakes/domain/usecases/set_show_pet_photo_usecase.dart';
import 'package:bite_buddy/features/keepsakes/presentation/bloc/keepsakes_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> keepsakesInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<KeepsakesCubit>(
    () => KeepsakesCubit(
      fetchKeepsakesUseCase: sl.call(),
      createWalletUseCase: sl.call(),
      setShowPetPhotoUseCase: sl.call(),
      mintKeepsakeUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchKeepsakesUseCase>(
    () => FetchKeepsakesUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<CreateWalletUseCase>(
    () => CreateWalletUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<SetShowPetPhotoUseCase>(
    () => SetShowPetPhotoUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<MintKeepsakeUseCase>(
    () => MintKeepsakeUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<KeepsakeRepository>(
    () => KeepsakeRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<KeepsakeRemoteDataSource>(
    () => KeepsakeRemoteDataSourceImpl(client: sl.call()),
  );
}

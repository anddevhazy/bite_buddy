import 'package:bite_buddy/features/pet/data/data_sources/remote/pet_remote_data_source.dart';
import 'package:bite_buddy/features/pet/data/data_sources/remote/pet_remote_data_source_impl.dart';
import 'package:bite_buddy/features/pet/data/repository/pet_repository_impl.dart';
import 'package:bite_buddy/features/pet/domain/repositories/pet_repository.dart';
import 'package:bite_buddy/features/pet/domain/usecases/adopt_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_my_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_species_usecase.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> petInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<PetCubit>(
    () => PetCubit(
      fetchMyPetUseCase: sl.call(),
      fetchSpeciesUseCase: sl.call(),
      adoptPetUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchMyPetUseCase>(
    () => FetchMyPetUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FetchSpeciesUseCase>(
    () => FetchSpeciesUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<AdoptPetUseCase>(
    () => AdoptPetUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<PetRemoteDataSource>(
    () => PetRemoteDataSourceImpl(client: sl.call()),
  );
}

import 'package:bite_buddy/features/collection/data/data_sources/remote/collection_remote_data_source.dart';
import 'package:bite_buddy/features/collection/data/data_sources/remote/collection_remote_data_source_impl.dart';
import 'package:bite_buddy/features/collection/data/repository/collection_repository_impl.dart';
import 'package:bite_buddy/features/collection/domain/repositories/collection_repository.dart';
import 'package:bite_buddy/features/collection/domain/usecases/fetch_leaderboard_usecase.dart';
import 'package:bite_buddy/features/collection/domain/usecases/fetch_meal_history_usecase.dart';
import 'package:bite_buddy/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> collectionInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<CollectionCubit>(
    () => CollectionCubit(
      fetchLeaderboardUseCase: sl.call(),
      fetchMealHistoryUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchLeaderboardUseCase>(
    () => FetchLeaderboardUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FetchMealHistoryUseCase>(
    () => FetchMealHistoryUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<CollectionRepository>(
    () => CollectionRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<CollectionRemoteDataSource>(
    () => CollectionRemoteDataSourceImpl(client: sl.call()),
  );
}

import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source_impl.dart';
import 'package:bite_buddy/features/battle/data/repository/battle_repository_impl.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/battle/domain/usecases/fetch_arena_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/finish_run_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/start_run_usecase.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> battleInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<BattleCubit>(
    () => BattleCubit(
      fetchArenaUseCase: sl.call(),
      startRunUseCase: sl.call(),
      finishRunUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchArenaUseCase>(
    () => FetchArenaUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<StartRunUseCase>(
    () => StartRunUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FinishRunUseCase>(
    () => FinishRunUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<BattleRepository>(
    () => BattleRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<BattleRemoteDataSource>(
    () => BattleRemoteDataSourceImpl(client: sl.call()),
  );
}

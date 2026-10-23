import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source.dart';
import 'package:bite_buddy/features/battle/data/data_sources/remote/battle_remote_data_source_impl.dart';
import 'package:bite_buddy/features/battle/data/repository/battle_repository_impl.dart';
import 'package:bite_buddy/features/battle/domain/repositories/battle_repository.dart';
import 'package:bite_buddy/features/battle/domain/usecases/fetch_opponents_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/play_move_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/start_battle_usecase.dart';
import 'package:bite_buddy/features/battle/presentation/bloc/battle_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> battleInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<BattleCubit>(
    () => BattleCubit(
      fetchOpponentsUseCase: sl.call(),
      startBattleUseCase: sl.call(),
      playMoveUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchOpponentsUseCase>(
    () => FetchOpponentsUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<StartBattleUseCase>(
    () => StartBattleUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<PlayMoveUseCase>(
    () => PlayMoveUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<BattleRepository>(
    () => BattleRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<BattleRemoteDataSource>(
    () => BattleRemoteDataSourceImpl(client: sl.call()),
  );
}

import 'package:bite_buddy/features/activity/data/data_sources/local/health_data_source.dart';
import 'package:bite_buddy/features/activity/data/data_sources/local/health_data_source_impl.dart';
import 'package:bite_buddy/features/activity/data/data_sources/remote/activity_remote_data_source.dart';
import 'package:bite_buddy/features/activity/data/data_sources/remote/activity_remote_data_source_impl.dart';
import 'package:bite_buddy/features/activity/data/repository/activity_repository_impl.dart';
import 'package:bite_buddy/features/activity/domain/repositories/activity_repository.dart';
import 'package:bite_buddy/features/activity/domain/usecases/connect_health_usecase.dart';
import 'package:bite_buddy/features/activity/domain/usecases/sync_activity_usecase.dart';
import 'package:bite_buddy/features/activity/presentation/bloc/activity_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';

Future<void> activityInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<ActivityCubit>(
    () => ActivityCubit(
      repository: sl.call(),
      connectHealthUseCase: sl.call(),
      syncActivityUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<ConnectHealthUseCase>(
    () => ConnectHealthUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<SyncActivityUseCase>(
    () => SyncActivityUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      healthDataSource: sl.call(),
      remoteDataSource: sl.call(),
    ),
  );

  sl.registerLazySingleton<HealthDataSource>(
    () => HealthDataSourceImpl(
      health: Health(),
      storage: const FlutterSecureStorage(),
    ),
  );

  sl.registerLazySingleton<ActivityRemoteDataSource>(
    () => ActivityRemoteDataSourceImpl(client: sl.call()),
  );
}

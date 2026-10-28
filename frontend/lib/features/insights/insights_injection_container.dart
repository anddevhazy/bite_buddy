import 'package:bite_buddy/features/insights/data/data_sources/remote/insights_remote_data_source.dart';
import 'package:bite_buddy/features/insights/data/data_sources/remote/insights_remote_data_source_impl.dart';
import 'package:bite_buddy/features/insights/data/repository/insights_repository_impl.dart';
import 'package:bite_buddy/features/insights/domain/repositories/insights_repository.dart';
import 'package:bite_buddy/features/insights/domain/usecases/fetch_insights_usecase.dart';
import 'package:bite_buddy/features/insights/presentation/bloc/insights_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> insightsInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<InsightsCubit>(
    () => InsightsCubit(fetchInsightsUseCase: sl.call()),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchInsightsUseCase>(
    () => FetchInsightsUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<InsightsRepository>(
    () => InsightsRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<InsightsRemoteDataSource>(
    () => InsightsRemoteDataSourceImpl(client: sl.call()),
  );
}

import 'package:bite_buddy/features/streak/data/data_sources/remote/streak_remote_data_source.dart';
import 'package:bite_buddy/features/streak/data/data_sources/remote/streak_remote_data_source_impl.dart';
import 'package:bite_buddy/features/streak/data/repository/streak_repository_impl.dart';
import 'package:bite_buddy/features/streak/domain/repositories/streak_repository.dart';
import 'package:bite_buddy/features/streak/domain/usecases/accept_streak_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/fetch_streak_candidates_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/fetch_streaks_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/invite_streak_friend_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/remove_streak_usecase.dart';
import 'package:bite_buddy/features/streak/presentation/bloc/streaks_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> streakInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<StreaksCubit>(
    () => StreaksCubit(
      fetchStreaksUseCase: sl.call(),
      fetchCandidatesUseCase: sl.call(),
      inviteUseCase: sl.call(),
      acceptUseCase: sl.call(),
      removeUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchStreaksUseCase>(
    () => FetchStreaksUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<FetchStreakCandidatesUseCase>(
    () => FetchStreakCandidatesUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<InviteStreakFriendUseCase>(
    () => InviteStreakFriendUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<AcceptStreakUseCase>(
    () => AcceptStreakUseCase(repository: sl.call()),
  );
  sl.registerLazySingleton<RemoveStreakUseCase>(
    () => RemoveStreakUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<StreakRepository>(
    () => StreakRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<StreakRemoteDataSource>(
    () => StreakRemoteDataSourceImpl(client: sl.call()),
  );
}

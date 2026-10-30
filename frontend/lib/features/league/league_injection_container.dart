import 'package:bite_buddy/features/league/data/data_sources/remote/league_remote_data_source.dart';
import 'package:bite_buddy/features/league/data/data_sources/remote/league_remote_data_source_impl.dart';
import 'package:bite_buddy/features/league/data/repository/league_repository_impl.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:bite_buddy/features/league/domain/usecases/challenge_friend_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/create_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_duel_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_my_leagues_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_trophies_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/join_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/leave_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/play_duel_move_usecase.dart';
import 'package:bite_buddy/features/league/presentation/bloc/duel_cubit.dart';
import 'package:bite_buddy/features/league/presentation/bloc/league_detail_cubit.dart';
import 'package:bite_buddy/features/league/presentation/bloc/leagues_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> leagueInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<LeaguesCubit>(
    () => LeaguesCubit(
      fetchMyLeaguesUseCase: sl.call(),
      createLeagueUseCase: sl.call(),
      joinLeagueUseCase: sl.call(),
    ),
  );

  sl.registerFactory<LeagueDetailCubit>(
    () => LeagueDetailCubit(
      fetchLeagueUseCase: sl.call(),
      challengeFriendUseCase: sl.call(),
      leaveLeagueUseCase: sl.call(),
    ),
  );

  sl.registerFactory<DuelCubit>(
    () =>
        DuelCubit(fetchDuelUseCase: sl.call(), playDuelMoveUseCase: sl.call()),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton(() => FetchMyLeaguesUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateLeagueUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => JoinLeagueUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FetchLeagueUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LeaveLeagueUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FetchTrophiesUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ChallengeFriendUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FetchDuelUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => PlayDuelMoveUseCase(repository: sl.call()));

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<LeagueRepository>(
    () => LeagueRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<LeagueRemoteDataSource>(
    () => LeagueRemoteDataSourceImpl(client: sl.call()),
  );
}

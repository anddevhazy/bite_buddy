import 'package:bite_buddy/features/social/data/data_sources/remote/social_remote_data_source.dart';
import 'package:bite_buddy/features/social/data/data_sources/remote/social_remote_data_source_impl.dart';
import 'package:bite_buddy/features/social/data/repository/social_repository_impl.dart';
import 'package:bite_buddy/features/social/domain/repositories/social_repository.dart';
import 'package:bite_buddy/features/social/domain/usecases/accept_friend_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/add_friend_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/create_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_challenges_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_friend_code_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_friends_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/join_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/leave_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/remove_friend_usecase.dart';
import 'package:bite_buddy/features/social/presentation/bloc/social_cubit.dart';
import 'package:bite_buddy/service_locator.dart';

Future<void> socialInjectionContainer() async {
  // * CUBITS INJECTION
  sl.registerFactory<SocialCubit>(
    () => SocialCubit(
      fetchFriendCodeUseCase: sl.call(),
      fetchFriendsUseCase: sl.call(),
      addFriendUseCase: sl.call(),
      acceptFriendUseCase: sl.call(),
      removeFriendUseCase: sl.call(),
      fetchChallengesUseCase: sl.call(),
      createChallengeUseCase: sl.call(),
      joinChallengeUseCase: sl.call(),
      leaveChallengeUseCase: sl.call(),
    ),
  );

  // * USE CASES INJECTION
  sl.registerLazySingleton<FetchFriendCodeUseCase>(
    () => FetchFriendCodeUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FetchFriendsUseCase>(
    () => FetchFriendsUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<AddFriendUseCase>(
    () => AddFriendUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<AcceptFriendUseCase>(
    () => AcceptFriendUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<RemoveFriendUseCase>(
    () => RemoveFriendUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<FetchChallengesUseCase>(
    () => FetchChallengesUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<CreateChallengeUseCase>(
    () => CreateChallengeUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<JoinChallengeUseCase>(
    () => JoinChallengeUseCase(repository: sl.call()),
  );

  sl.registerLazySingleton<LeaveChallengeUseCase>(
    () => LeaveChallengeUseCase(repository: sl.call()),
  );

  // * REPOSITORY & DATA SOURCES INJECTION
  sl.registerLazySingleton<SocialRepository>(
    () => SocialRepositoryImpl(remoteDataSource: sl.call()),
  );

  sl.registerLazySingleton<SocialRemoteDataSource>(
    () => SocialRemoteDataSourceImpl(client: sl.call()),
  );
}

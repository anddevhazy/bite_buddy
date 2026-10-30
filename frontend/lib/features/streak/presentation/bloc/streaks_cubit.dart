import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy/features/streak/domain/usecases/accept_streak_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/fetch_streak_candidates_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/fetch_streaks_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/invite_streak_friend_usecase.dart';
import 'package:bite_buddy/features/streak/domain/usecases/remove_streak_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'streaks_state.dart';

// Your shared streaks with friends, shown on My Pet
class StreaksCubit extends Cubit<StreaksState> {
  final FetchStreaksUseCase fetchStreaksUseCase;
  final FetchStreakCandidatesUseCase fetchCandidatesUseCase;
  final InviteStreakFriendUseCase inviteUseCase;
  final AcceptStreakUseCase acceptUseCase;
  final RemoveStreakUseCase removeUseCase;

  StreaksCubit({
    required this.fetchStreaksUseCase,
    required this.fetchCandidatesUseCase,
    required this.inviteUseCase,
    required this.acceptUseCase,
    required this.removeUseCase,
  }) : super(StreaksInitial());

  Future<void> load() async {
    if (state is! StreaksLoaded) emit(StreaksLoading());
    final result = await fetchStreaksUseCase.call();
    result.fold((failure) {
      // Keep the list we had; only show the error if there's none
      if (state is! StreaksLoaded) emit(StreaksFailed(failure: failure));
    }, (streaks) => emit(StreaksLoaded(streaks: streaks)));
  }

  Future<Either<Failure, List<StreakFriendEntity>>> candidates() =>
      fetchCandidatesUseCase.call();

  // Each action reloads the list when it works and hands back the result so
  // the card can show an error
  Future<Either<Failure, SharedStreakEntity>> invite(String userId) =>
      _thenReload(inviteUseCase.call(userId));

  Future<Either<Failure, SharedStreakEntity>> accept(int id) =>
      _thenReload(acceptUseCase.call(id));

  Future<Either<Failure, Unit>> remove(int id) =>
      _thenReload(removeUseCase.call(id));

  Future<Either<Failure, T>> _thenReload<T>(
    Future<Either<Failure, T>> action,
  ) async {
    final result = await action;
    if (result.isRight()) await load();
    return result;
  }

  void reset() => emit(StreaksInitial());
}

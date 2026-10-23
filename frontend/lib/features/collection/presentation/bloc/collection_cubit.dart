import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/collection/domain/usecases/fetch_leaderboard_usecase.dart';
import 'package:bite_buddy/features/collection/domain/usecases/fetch_meal_history_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final FetchLeaderboardUseCase fetchLeaderboardUseCase;
  final FetchMealHistoryUseCase fetchMealHistoryUseCase;

  CollectionCubit({
    required this.fetchLeaderboardUseCase,
    required this.fetchMealHistoryUseCase,
  }) : super(CollectionInitial());

  Future<void> load() async {
    // Keep showing the old lists while refreshing
    if (state is! CollectionLoaded) emit(CollectionLoading());

    final (leaderboardResult, mealsResult) =
        await (fetchLeaderboardUseCase.call(), fetchMealHistoryUseCase.call())
            .wait;

    leaderboardResult.fold(
      (failure) => emit(CollectionFailed(failure: failure)),
      (leaderboard) => mealsResult.fold(
        (failure) => emit(CollectionFailed(failure: failure)),
        (meals) =>
            emit(CollectionLoaded(leaderboard: leaderboard, meals: meals)),
      ),
    );
  }
}

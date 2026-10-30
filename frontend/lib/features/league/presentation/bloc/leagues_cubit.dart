import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/usecases/create_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_my_leagues_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/join_league_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'leagues_state.dart';

// Your leagues. Also drives the "your turn" badge on the Battle tab.
class LeaguesCubit extends Cubit<LeaguesState> {
  final FetchMyLeaguesUseCase fetchMyLeaguesUseCase;
  final CreateLeagueUseCase createLeagueUseCase;
  final JoinLeagueUseCase joinLeagueUseCase;

  LeaguesCubit({
    required this.fetchMyLeaguesUseCase,
    required this.createLeagueUseCase,
    required this.joinLeagueUseCase,
  }) : super(LeaguesInitial());

  int get yourTurnCount => switch (state) {
    LeaguesLoaded(:final yourTurnCount) => yourTurnCount,
    _ => 0,
  };

  Future<void> load() async {
    if (state is! LeaguesLoaded) emit(LeaguesLoading());
    final result = await fetchMyLeaguesUseCase.call();
    result.fold((failure) {
      // Keep showing the list we had; only show the error if there's none
      if (state is! LeaguesLoaded) emit(LeaguesFailed(failure: failure));
    }, (leagues) => emit(LeaguesLoaded(leagues: leagues)));
  }

  // Create and join return the new league so the page can open it
  Future<Either<Failure, LeagueDetailEntity>> create(String name) async {
    final result = await createLeagueUseCase.call(name);
    if (result.isRight()) await load();
    return result;
  }

  Future<Either<Failure, LeagueDetailEntity>> join(String code) async {
    final result = await joinLeagueUseCase.call(code);
    if (result.isRight()) await load();
    return result;
  }

  void reset() => emit(LeaguesInitial());
}

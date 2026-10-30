import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/usecases/challenge_friend_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_league_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/leave_league_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'league_detail_state.dart';

// One league's screen: the season table and your friend battles
class LeagueDetailCubit extends Cubit<LeagueDetailState> {
  final FetchLeagueUseCase fetchLeagueUseCase;
  final ChallengeFriendUseCase challengeFriendUseCase;
  final LeaveLeagueUseCase leaveLeagueUseCase;

  late int _leagueId;

  LeagueDetailCubit({
    required this.fetchLeagueUseCase,
    required this.challengeFriendUseCase,
    required this.leaveLeagueUseCase,
  }) : super(LeagueDetailLoading());

  Future<void> load(int leagueId) async {
    _leagueId = leagueId;
    await refresh();
  }

  Future<void> refresh() async {
    final result = await fetchLeagueUseCase.call(_leagueId);
    result.fold((failure) {
      if (state is! LeagueDetailLoaded) {
        emit(LeagueDetailFailed(failure: failure));
      }
    }, (league) => emit(LeagueDetailLoaded(league: league)));
  }

  // Starts a friend battle; returns it so the page can open it
  Future<Either<Failure, DuelEntity>> challenge(int memberId) async {
    final current = state;
    if (current is! LeagueDetailLoaded) {
      return const Left(UnexpectedFailure('League not loaded'));
    }
    emit(
      LeagueDetailLoaded(league: current.league, challengingMemberId: memberId),
    );
    final result = await challengeFriendUseCase.call(_leagueId, memberId);
    emit(LeagueDetailLoaded(league: current.league));
    if (result.isRight()) await refresh();
    return result;
  }

  Future<Either<Failure, void>> leave() => leaveLeagueUseCase.call(_leagueId);
}

part of 'league_detail_cubit.dart';

abstract class LeagueDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeagueDetailLoading extends LeagueDetailState {}

class LeagueDetailLoaded extends LeagueDetailState {
  final LeagueDetailEntity league;
  // The member being challenged right now, if any
  final int? challengingMemberId;

  LeagueDetailLoaded({required this.league, this.challengingMemberId});

  @override
  List<Object?> get props => [league, challengingMemberId];
}

class LeagueDetailFailed extends LeagueDetailState {
  final Failure failure;

  LeagueDetailFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

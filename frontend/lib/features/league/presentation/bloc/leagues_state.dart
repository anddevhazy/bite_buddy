part of 'leagues_cubit.dart';

abstract class LeaguesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoading extends LeaguesState {}

class LeaguesLoaded extends LeaguesState {
  final List<LeagueSummaryEntity> leagues;

  LeaguesLoaded({required this.leagues});

  // Friend battles waiting for your move, across all leagues
  int get yourTurnCount => leagues.fold(0, (n, l) => n + l.yourTurnCount);

  @override
  List<Object?> get props => [leagues];
}

class LeaguesFailed extends LeaguesState {
  final Failure failure;

  LeaguesFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

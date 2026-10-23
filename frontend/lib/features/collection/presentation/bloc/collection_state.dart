part of 'collection_cubit.dart';

abstract class CollectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CollectionInitial extends CollectionState {}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<LeaderboardEntryEntity> leaderboard;
  final List<MealEntity> meals;

  CollectionLoaded({required this.leaderboard, required this.meals});

  @override
  List<Object?> get props => [leaderboard, meals];
}

class CollectionFailed extends CollectionState {
  final Failure failure;

  CollectionFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

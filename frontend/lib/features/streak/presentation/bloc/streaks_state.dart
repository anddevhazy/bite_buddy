part of 'streaks_cubit.dart';

abstract class StreaksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StreaksInitial extends StreaksState {}

class StreaksLoading extends StreaksState {}

class StreaksLoaded extends StreaksState {
  final List<SharedStreakEntity> streaks;

  StreaksLoaded({required this.streaks});

  @override
  List<Object?> get props => [streaks];
}

class StreaksFailed extends StreaksState {
  final Failure failure;

  StreaksFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

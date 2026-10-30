part of 'duel_cubit.dart';

abstract class DuelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DuelLoading extends DuelState {}

class DuelLoaded extends DuelState {
  final DuelEntity duel;
  // True while your move is being sent
  final bool submitting;

  DuelLoaded({required this.duel, this.submitting = false});

  @override
  List<Object?> get props => [duel, submitting];
}

// A failure to show as a toast; the cubit goes back to DuelLoaded after it
class DuelFailed extends DuelState {
  final Failure failure;

  DuelFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

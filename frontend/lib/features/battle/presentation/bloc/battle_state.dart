part of 'battle_cubit.dart';

abstract class BattleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BattleInitial extends BattleState {}

class OpponentsLoading extends BattleState {}

class OpponentsLoaded extends BattleState {
  final ArenaEntity arena;

  OpponentsLoaded({required this.arena});

  List<OpponentEntity> get opponents => arena.opponents;

  @override
  List<Object?> get props => [arena];
}

// Waiting for the server to set up a battle against [opponentKey]
class BattleStarting extends OpponentsLoaded {
  final String opponentKey;

  BattleStarting({required super.arena, required this.opponentKey});

  @override
  List<Object?> get props => [arena, opponentKey];
}

class InBattle extends BattleState {
  final BattleEntity battle;
  // True while a move is being resolved on the server
  final bool resolving;

  InBattle({required this.battle, this.resolving = false});

  @override
  List<Object?> get props => [battle, resolving];
}

class BattleFailed extends BattleState {
  final Failure failure;

  BattleFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

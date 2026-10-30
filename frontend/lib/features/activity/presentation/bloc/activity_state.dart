part of 'activity_cubit.dart';

abstract class ActivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

// The health app hasn't been connected yet
class ActivityNotConnected extends ActivityState {
  final HealthSource source;
  final bool connecting;

  ActivityNotConnected({required this.source, this.connecting = false});

  @override
  List<Object?> get props => [source, connecting];
}

class ActivitySyncing extends ActivityState {}

class ActivitySynced extends ActivityState {
  final ActivitySyncEntity activity;

  ActivitySynced({required this.activity});

  @override
  List<Object?> get props => [activity];
}

class ActivityFailed extends ActivityState {
  final Failure failure;

  ActivityFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

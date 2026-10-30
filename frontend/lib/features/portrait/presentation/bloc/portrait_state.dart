part of 'portrait_cubit.dart';

abstract class PortraitState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Waiting for a photo
class PortraitInitial extends PortraitState {}

// The photo is being checked and redrawn
class PortraitMaking extends PortraitState {}

class PortraitReady extends PortraitState {
  final PortraitDraftEntity draft;
  final bool applying;

  PortraitReady({required this.draft, this.applying = false});

  @override
  List<Object?> get props => [draft, applying];
}

class PortraitFailed extends PortraitState {
  final Failure failure;

  PortraitFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

// The picture is on the pet now
class PortraitApplied extends PortraitState {
  final PetEntity pet;

  PortraitApplied({required this.pet});

  @override
  List<Object?> get props => [pet];
}

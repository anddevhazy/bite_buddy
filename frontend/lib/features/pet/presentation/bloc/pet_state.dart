part of 'pet_cubit.dart';

abstract class PetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final PetEntity pet;

  PetLoaded({required this.pet});

  @override
  List<Object?> get props => [pet];
}

// Signed in but no pet yet: show the buddy picker
class NoPet extends PetState {
  final List<PetSpeciesEntity> species;

  NoPet({required this.species});

  @override
  List<Object?> get props => [species];
}

class Adopting extends NoPet {
  Adopting({required super.species});
}

class PetFailed extends PetState {
  final Failure failure;

  PetFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

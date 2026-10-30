part of 'meal_ideas_cubit.dart';

abstract class MealIdeasState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealIdeasInitial extends MealIdeasState {}

class MealIdeasLoading extends MealIdeasState {}

class MealIdeasLoaded extends MealIdeasState {
  final List<MealIdeaEntity> ideas;

  MealIdeasLoaded({required this.ideas});

  @override
  List<Object?> get props => [ideas];
}

class MealIdeasFailed extends MealIdeasState {
  final Failure failure;

  MealIdeasFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

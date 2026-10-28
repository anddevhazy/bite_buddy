part of 'insights_cubit.dart';

abstract class InsightsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InsightsInitial extends InsightsState {}

class InsightsLoading extends InsightsState {}

class InsightsLoaded extends InsightsState {
  final NutritionInsightsEntity insights;

  InsightsLoaded({required this.insights});

  @override
  List<Object?> get props => [insights];
}

class InsightsFailed extends InsightsState {
  final Failure failure;

  InsightsFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

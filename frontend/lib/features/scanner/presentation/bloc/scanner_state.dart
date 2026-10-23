part of 'scanner_cubit.dart';

abstract class ScannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScannerIdle extends ScannerState {}

class Analyzing extends ScannerState {}

class MealAnalyzed extends ScannerState {
  final MealEntity meal;

  MealAnalyzed({required this.meal});

  @override
  List<Object?> get props => [meal];
}

class Feeding extends MealAnalyzed {
  Feeding({required super.meal});
}

class MealFed extends MealAnalyzed {
  final FeedResultEntity result;

  MealFed({required super.meal, required this.result});

  @override
  List<Object?> get props => [meal, result];
}

// The photo wasn't a live meal (or was already scanned)
class MealRejected extends ScannerState {
  final String reason;

  MealRejected({required this.reason});

  @override
  List<Object?> get props => [reason];
}

class ScannerFailed extends ScannerState {
  final Failure failure;
  // Set when feeding failed, so the result screen can stay up
  final MealEntity? meal;

  ScannerFailed({required this.failure, this.meal});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message, meal];
}

part of 'memory_book_cubit.dart';

abstract class MemoryBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemoryBookLoading extends MemoryBookState {}

class MemoryBookLoaded extends MemoryBookState {
  final MemoryBookEntity book;

  MemoryBookLoaded({required this.book});

  @override
  List<Object?> get props => [book];
}

class MemoryBookFailed extends MemoryBookState {
  final Failure failure;

  MemoryBookFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

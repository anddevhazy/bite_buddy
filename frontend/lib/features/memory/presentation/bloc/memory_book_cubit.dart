import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/memory/domain/entities/memory_book_entity.dart';
import 'package:bite_buddy/features/memory/domain/usecases/fetch_memory_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'memory_book_state.dart';

class MemoryBookCubit extends Cubit<MemoryBookState> {
  final FetchMemoryBookUseCase fetchMemoryBookUseCase;

  MemoryBookCubit({required this.fetchMemoryBookUseCase})
    : super(MemoryBookLoading());

  Future<void> load() async {
    // Keep showing the book while refreshing
    if (state is! MemoryBookLoaded) emit(MemoryBookLoading());
    final result = await fetchMemoryBookUseCase.call();
    result.fold((failure) {
      if (state is! MemoryBookLoaded) emit(MemoryBookFailed(failure: failure));
    }, (book) => emit(MemoryBookLoaded(book: book)));
  }
}

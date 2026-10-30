import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/domain/entities/meal_idea_entity.dart';
import 'package:bite_buddy/features/insights/domain/usecases/fetch_meal_ideas_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meal_ideas_state.dart';

// Today's meal ideas. Only loaded when asked for, since each new day's set
// costs an AI call.
class MealIdeasCubit extends Cubit<MealIdeasState> {
  final FetchMealIdeasUseCase fetchMealIdeasUseCase;

  MealIdeasCubit({required this.fetchMealIdeasUseCase})
    : super(MealIdeasInitial());

  Future<void> load() async {
    emit(MealIdeasLoading());
    final result = await fetchMealIdeasUseCase.call();
    result.fold(
      (failure) => emit(MealIdeasFailed(failure: failure)),
      (ideas) => emit(MealIdeasLoaded(ideas: ideas)),
    );
  }
}

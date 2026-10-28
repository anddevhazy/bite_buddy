import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/insights/domain/entities/nutrition_insights_entity.dart';
import 'package:bite_buddy/features/insights/domain/usecases/fetch_insights_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'insights_state.dart';

class InsightsCubit extends Cubit<InsightsState> {
  final FetchInsightsUseCase fetchInsightsUseCase;

  InsightsCubit({required this.fetchInsightsUseCase})
    : super(InsightsInitial());

  Future<void> load() async {
    // Keep showing the old summary while refreshing
    if (state is! InsightsLoaded) emit(InsightsLoading());

    final result = await fetchInsightsUseCase.call();
    result.fold(
      (failure) => emit(InsightsFailed(failure: failure)),
      (insights) => emit(InsightsLoaded(insights: insights)),
    );
  }

  void reset() => emit(InsightsInitial());
}

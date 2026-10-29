import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/scanner/domain/entities/feed_result_entity.dart';
import 'package:bite_buddy/features/scanner/domain/entities/meal_entity.dart';
import 'package:bite_buddy/features/scanner/domain/usecases/analyze_meal_usecase.dart';
import 'package:bite_buddy/features/scanner/domain/usecases/feed_pet_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final AnalyzeMealUseCase analyzeMealUseCase;
  final FeedPetUseCase feedPetUseCase;

  // The last photo taken, shown on the results screen
  Uint8List? photo;

  ScannerCubit({required this.analyzeMealUseCase, required this.feedPetUseCase})
    : super(ScannerIdle());

  Future<void> analyze(Uint8List jpegBytes) async {
    photo = jpegBytes;
    emit(Analyzing());
    final result = await analyzeMealUseCase.call(jpegBytes);
    result.fold((failure) {
      if (failure is MealRejectedFailure) {
        emit(MealRejected(reason: failure.message));
      } else {
        emit(ScannerFailed(failure: failure));
      }
    }, (meal) => emit(MealAnalyzed(meal: meal)));
  }

  Future<void> feed() async {
    final current = state;
    if (current is! MealAnalyzed || current is Feeding || current is MealFed) {
      return;
    }
    final meal = current.meal;

    emit(Feeding(meal: meal));
    final result = await feedPetUseCase.call(meal.id);
    result.fold(
      (failure) => emit(ScannerFailed(failure: failure, meal: meal)),
      (fed) => emit(MealFed(meal: meal, result: fed)),
    );
  }

  // Show a meal scanned earlier (from the meal log) on the results screen.
  // There's no photo for it; only the nutrition was saved.
  void review(MealEntity meal) {
    photo = null;
    emit(MealAnalyzed(meal: meal));
  }

  void reset() {
    photo = null;
    emit(ScannerIdle());
  }
}

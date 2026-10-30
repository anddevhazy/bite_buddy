import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/apply_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/clear_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/create_portrait_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'portrait_state.dart';

// "Use my own pet": photo in, buddy picture out, then onto the pet
class PortraitCubit extends Cubit<PortraitState> {
  final CreatePortraitUseCase createPortraitUseCase;
  final ApplyPortraitUseCase applyPortraitUseCase;
  final ClearPortraitUseCase clearPortraitUseCase;

  PortraitCubit({
    required this.createPortraitUseCase,
    required this.applyPortraitUseCase,
    required this.clearPortraitUseCase,
  }) : super(PortraitInitial());

  Future<void> make(Uint8List photo) async {
    emit(PortraitMaking());
    final result = await createPortraitUseCase.call(photo);
    result.fold(
      (failure) => emit(PortraitFailed(failure: failure)),
      (draft) => emit(PortraitReady(draft: draft)),
    );
  }

  Future<void> apply() async {
    final current = state;
    if (current is! PortraitReady) return;
    emit(PortraitReady(draft: current.draft, applying: true));
    final result = await applyPortraitUseCase.call(current.draft.id);
    result.fold((failure) {
      emit(PortraitFailed(failure: failure));
      emit(PortraitReady(draft: current.draft));
    }, (pet) => emit(PortraitApplied(pet: pet)));
  }

  Future<void> clear() async {
    emit(PortraitMaking());
    final result = await clearPortraitUseCase.call();
    result.fold(
      (failure) => emit(PortraitFailed(failure: failure)),
      (pet) => emit(PortraitApplied(pet: pet)),
    );
  }

  void startOver() => emit(PortraitInitial());
}

import 'dart:typed_data';

import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/adopt_with_portrait_usecase.dart';
import 'package:bite_buddy/features/portrait/domain/usecases/create_portrait_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'portrait_state.dart';

// "My own pet": photo in, buddy picture out, then adopted
class PortraitCubit extends Cubit<PortraitState> {
  final CreatePortraitUseCase createPortraitUseCase;
  final AdoptWithPortraitUseCase adoptWithPortraitUseCase;

  PortraitCubit({
    required this.createPortraitUseCase,
    required this.adoptWithPortraitUseCase,
  }) : super(PortraitInitial());

  Future<void> make(Uint8List photo) async {
    emit(PortraitMaking());
    final result = await createPortraitUseCase.call(photo);
    result.fold(
      (failure) => emit(PortraitFailed(failure: failure)),
      (draft) => emit(PortraitReady(draft: draft)),
    );
  }

  Future<void> adopt(String name) async {
    final current = state;
    if (current is! PortraitReady) return;
    emit(PortraitReady(draft: current.draft, adopting: true));
    final result = await adoptWithPortraitUseCase.call(current.draft.id, name);
    result.fold((failure) {
      emit(PortraitFailed(failure: failure));
      emit(PortraitReady(draft: current.draft));
    }, (pet) => emit(PortraitAdopted(pet: pet)));
  }

  void startOver() => emit(PortraitInitial());
}

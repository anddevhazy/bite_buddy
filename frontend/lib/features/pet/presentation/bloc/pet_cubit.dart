import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy/features/pet/domain/usecases/adopt_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_my_pet_usecase.dart';
import 'package:bite_buddy/features/pet/domain/usecases/fetch_species_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final FetchMyPetUseCase fetchMyPetUseCase;
  final FetchSpeciesUseCase fetchSpeciesUseCase;
  final AdoptPetUseCase adoptPetUseCase;

  PetCubit({
    required this.fetchMyPetUseCase,
    required this.fetchSpeciesUseCase,
    required this.adoptPetUseCase,
  }) : super(PetInitial());

  PetEntity? get pet => switch (state) {
    PetLoaded(:final pet) => pet,
    _ => null,
  };

  Future<void> loadPet({bool silent = false}) async {
    if (!silent) emit(PetLoading());
    final result = await fetchMyPetUseCase.call();
    await result.fold(
      (failure) async => emit(PetFailed(failure: failure)),
      (pet) async {
        if (pet != null) {
          emit(PetLoaded(pet: pet));
        } else {
          await _showSpecies();
        }
      },
    );
  }

  Future<void> adopt(String speciesKey, String name) async {
    final current = state;
    final species = current is NoPet ? current.species : <PetSpeciesEntity>[];
    emit(Adopting(species: species));

    final result = await adoptPetUseCase.call(speciesKey, name);
    result.fold((failure) {
      emit(PetFailed(failure: failure));
      emit(NoPet(species: species));
    }, (pet) => emit(PetLoaded(pet: pet)));
  }

  // Feeding and battles return the updated pet, so no refetch is needed
  void updatePet(PetEntity pet) => emit(PetLoaded(pet: pet));

  void reset() => emit(PetInitial());

  Future<void> _showSpecies() async {
    final result = await fetchSpeciesUseCase.call();
    result.fold(
      (failure) => emit(PetFailed(failure: failure)),
      (species) => emit(NoPet(species: species)),
    );
  }
}

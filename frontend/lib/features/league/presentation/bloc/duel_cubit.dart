import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/usecases/fetch_duel_usecase.dart';
import 'package:bite_buddy/features/league/domain/usecases/play_duel_move_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'duel_state.dart';

// A friend battle. Moves are secret until both are in, so after picking you
// wait (and can refresh) until your friend has played too.
class DuelCubit extends Cubit<DuelState> {
  final FetchDuelUseCase fetchDuelUseCase;
  final PlayDuelMoveUseCase playDuelMoveUseCase;

  late int _duelId;
  DuelEntity? _duel;

  DuelCubit({required this.fetchDuelUseCase, required this.playDuelMoveUseCase})
    : super(DuelLoading());

  Future<void> load(int duelId) async {
    _duelId = duelId;
    await refresh();
  }

  Future<void> refresh() async {
    final result = await fetchDuelUseCase.call(_duelId);
    result.fold((failure) {
      emit(DuelFailed(failure: failure));
      if (_duel != null) emit(DuelLoaded(duel: _duel!));
    }, _show);
  }

  Future<void> play(BattleMove move) async {
    final duel = _duel;
    if (duel == null || !duel.yourTurn || duel.isOver) return;
    emit(DuelLoaded(duel: duel, submitting: true));
    final result = await playDuelMoveUseCase.call(_duelId, move);
    result.fold((failure) {
      emit(DuelFailed(failure: failure));
      emit(DuelLoaded(duel: duel));
    }, _show);
  }

  void _show(DuelEntity duel) {
    _duel = duel;
    emit(DuelLoaded(duel: duel));
  }
}

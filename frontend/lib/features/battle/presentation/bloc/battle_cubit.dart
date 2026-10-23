import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/domain/usecases/fetch_opponents_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/play_move_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/start_battle_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'battle_state.dart';

class BattleCubit extends Cubit<BattleState> {
  final FetchOpponentsUseCase fetchOpponentsUseCase;
  final StartBattleUseCase startBattleUseCase;
  final PlayMoveUseCase playMoveUseCase;

  List<OpponentEntity> _opponents = const [];

  BattleCubit({
    required this.fetchOpponentsUseCase,
    required this.startBattleUseCase,
    required this.playMoveUseCase,
  }) : super(BattleInitial());

  Future<void> loadOpponents() async {
    if (_opponents.isEmpty) emit(OpponentsLoading());
    final result = await fetchOpponentsUseCase.call();
    result.fold(
      (failure) {
        emit(BattleFailed(failure: failure));
        emit(OpponentsLoaded(opponents: _opponents));
      },
      (list) {
        _opponents = list;
        emit(OpponentsLoaded(opponents: list));
      },
    );
  }

  Future<void> start(String opponentKey) async {
    emit(BattleStarting(opponents: _opponents, opponentKey: opponentKey));
    final result = await startBattleUseCase.call(opponentKey);
    result.fold((failure) {
      emit(BattleFailed(failure: failure));
      emit(OpponentsLoaded(opponents: _opponents));
    }, (battle) => emit(InBattle(battle: battle)));
  }

  Future<void> play(BattleMove move) async {
    final current = state;
    if (current is! InBattle || current.resolving || current.battle.isOver) {
      return;
    }

    emit(InBattle(battle: current.battle, resolving: true));
    final result = await playMoveUseCase.call(current.battle.id, move);
    result.fold((failure) {
      emit(BattleFailed(failure: failure));
      emit(InBattle(battle: current.battle));
    }, (battle) => emit(InBattle(battle: battle)));
  }

  // Back to the arena; win chances change after a battle, so refresh them
  Future<void> leave() => loadOpponents();
}

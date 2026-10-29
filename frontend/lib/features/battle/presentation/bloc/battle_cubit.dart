import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/battle_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/domain/usecases/fetch_arena_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/play_move_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/start_battle_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'battle_state.dart';

class BattleCubit extends Cubit<BattleState> {
  final FetchArenaUseCase fetchArenaUseCase;
  final StartBattleUseCase startBattleUseCase;
  final PlayMoveUseCase playMoveUseCase;

  ArenaEntity? _arena;

  BattleCubit({
    required this.fetchArenaUseCase,
    required this.startBattleUseCase,
    required this.playMoveUseCase,
  }) : super(BattleInitial());

  Future<void> loadOpponents() async {
    if (_arena == null) emit(OpponentsLoading());
    final result = await fetchArenaUseCase.call();
    result.fold(
      (failure) {
        emit(BattleFailed(failure: failure));
        _showArena();
      },
      (arena) {
        _arena = arena;
        emit(OpponentsLoaded(arena: arena));
      },
    );
  }

  Future<void> start(String opponentKey) async {
    final arena = _arena;
    if (arena == null) return;
    emit(BattleStarting(arena: arena, opponentKey: opponentKey));
    final result = await startBattleUseCase.call(opponentKey);
    result.fold((failure) {
      emit(BattleFailed(failure: failure));
      _showArena();
    }, (battle) => emit(InBattle(battle: battle)));
  }

  // Back to the opponent list, or to the error view if it never loaded
  void _showArena() {
    final arena = _arena;
    emit(
      arena == null
          ? OpponentsLoaded(
              arena: const ArenaEntity(
                petStats: BattleStatsEntity(hp: 0, attack: 0, defense: 0),
                opponents: [],
              ),
            )
          : OpponentsLoaded(arena: arena),
    );
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

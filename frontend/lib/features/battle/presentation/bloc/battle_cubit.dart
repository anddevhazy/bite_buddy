import 'package:bite_buddy/features/battle/domain/entities/arena_entity.dart';
import 'package:bite_buddy/features/battle/domain/entities/arena_run_entities.dart';
import 'package:bite_buddy/features/battle/domain/entities/opponent_entity.dart';
import 'package:bite_buddy/features/battle/domain/usecases/fetch_arena_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/finish_run_usecase.dart';
import 'package:bite_buddy/features/battle/domain/usecases/start_run_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'battle_state.dart';

// The Battle Arena: opponents, and starting and reporting real-time fights.
// The fight itself runs in the fight screen's game.
class BattleCubit extends Cubit<BattleState> {
  final FetchArenaUseCase fetchArenaUseCase;
  final StartRunUseCase startRunUseCase;
  final FinishRunUseCase finishRunUseCase;

  ArenaEntity? _arena;

  BattleCubit({
    required this.fetchArenaUseCase,
    required this.startRunUseCase,
    required this.finishRunUseCase,
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
    final result = await startRunUseCase.call(opponentKey);
    result.fold(
      (failure) {
        emit(BattleFailed(failure: failure));
        _showArena();
      },
      (config) {
        emit(FightReady(arena: arena, config: config));
        // Back to the plain list, so returning to the arena doesn't reopen it
        emit(OpponentsLoaded(arena: arena));
      },
    );
  }

  // Called by the fight screen when the fight ends
  Future<Either<Failure, ArenaRunResultEntity>> finish(
    int runId,
    ArenaRunReportEntity report,
  ) => finishRunUseCase.call(runId, report);

  void _showArena() {
    final arena = _arena;
    emit(
      OpponentsLoaded(
        arena:
            arena ??
            const ArenaEntity(
              petStats: BattleStatsEntity(hp: 0, attack: 0, defense: 0),
              opponents: [],
            ),
      ),
    );
  }
}

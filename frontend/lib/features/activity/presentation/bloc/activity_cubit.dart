import 'package:bite_buddy/features/activity/domain/entities/activity_entities.dart';
import 'package:bite_buddy/features/activity/domain/repositories/activity_repository.dart';
import 'package:bite_buddy/features/activity/domain/usecases/connect_health_usecase.dart';
import 'package:bite_buddy/features/activity/domain/usecases/sync_activity_usecase.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activity_state.dart';

// Steps and sleep from Apple Health or Health Connect, on My Pet
class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repository;
  final ConnectHealthUseCase connectHealthUseCase;
  final SyncActivityUseCase syncActivityUseCase;

  ActivityCubit({
    required this.repository,
    required this.connectHealthUseCase,
    required this.syncActivityUseCase,
  }) : super(ActivityInitial());

  // Syncs if the health app is connected; otherwise offers to connect it
  Future<void> load() async {
    if (!await repository.isConnected()) {
      emit(ActivityNotConnected(source: repository.source));
      return;
    }
    await sync();
  }

  Future<void> connect() async {
    emit(ActivityNotConnected(source: repository.source, connecting: true));
    final result = await connectHealthUseCase.call();
    await result.fold((failure) async {
      emit(ActivityFailed(failure: failure));
      emit(ActivityNotConnected(source: repository.source));
    }, (_) => sync());
  }

  Future<void> disconnect() async {
    await repository.disconnect();
    emit(ActivityNotConnected(source: repository.source));
  }

  Future<void> sync() async {
    // Keep showing the old numbers while refreshing
    if (state is! ActivitySynced) emit(ActivitySyncing());
    final result = await syncActivityUseCase.call();
    result.fold((failure) {
      if (state is! ActivitySynced) emit(ActivityFailed(failure: failure));
    }, (activity) => emit(ActivitySynced(activity: activity)));
  }

  void reset() => emit(ActivityInitial());
}

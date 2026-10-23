import 'package:bite_buddy/features/collection/domain/entities/leaderboard_entry_entity.dart';
import 'package:bite_buddy/features/collection/domain/repositories/collection_repository.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class FetchLeaderboardUseCase {
  final CollectionRepository repository;

  FetchLeaderboardUseCase({required this.repository});

  Future<Either<Failure, List<LeaderboardEntryEntity>>> call() =>
      repository.fetchLeaderboard();
}

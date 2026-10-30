import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';

class ChallengeFriendUseCase {
  final LeagueRepository repository;

  ChallengeFriendUseCase({required this.repository});

  Future<Either<Failure, DuelEntity>> call(int leagueId, int memberId) =>
      repository.challenge(leagueId, memberId);
}

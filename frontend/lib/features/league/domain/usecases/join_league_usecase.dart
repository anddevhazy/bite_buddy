import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';

class JoinLeagueUseCase {
  final LeagueRepository repository;

  JoinLeagueUseCase({required this.repository});

  Future<Either<Failure, LeagueDetailEntity>> call(String inviteCode) =>
      repository.joinLeague(inviteCode);
}

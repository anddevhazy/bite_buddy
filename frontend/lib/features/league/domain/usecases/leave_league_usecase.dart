import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';

class LeaveLeagueUseCase {
  final LeagueRepository repository;

  LeaveLeagueUseCase({required this.repository});

  Future<Either<Failure, void>> call(int leagueId) =>
      repository.leaveLeague(leagueId);
}

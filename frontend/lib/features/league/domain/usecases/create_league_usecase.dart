import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';

class CreateLeagueUseCase {
  final LeagueRepository repository;

  CreateLeagueUseCase({required this.repository});

  Future<Either<Failure, LeagueDetailEntity>> call(String name) =>
      repository.createLeague(name);
}

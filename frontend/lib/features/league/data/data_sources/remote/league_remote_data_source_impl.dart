import 'package:bite_buddy/features/battle/data/models/battle_model.dart';
import 'package:bite_buddy/features/global/enums/battle_move.dart' as app;
import 'package:bite_buddy/features/league/data/data_sources/remote/league_remote_data_source.dart';
import 'package:bite_buddy/features/league/data/models/league_models.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class LeagueRemoteDataSourceImpl implements LeagueRemoteDataSource {
  final Client client;

  LeagueRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeagueSummaryEntity>> fetchMyLeagues() async =>
      (await client.league.myLeagues()).map(LeagueModels.summary).toList();

  @override
  Future<LeagueDetailEntity> createLeague(String name) async =>
      LeagueModels.detail(await client.league.create(name));

  @override
  Future<LeagueDetailEntity> joinLeague(String inviteCode) async =>
      LeagueModels.detail(await client.league.join(inviteCode));

  @override
  Future<LeagueDetailEntity> fetchLeague(int leagueId) async =>
      LeagueModels.detail(await client.league.detail(leagueId));

  @override
  Future<void> leaveLeague(int leagueId) => client.league.leave(leagueId);

  @override
  Future<List<TrophyEntity>> fetchTrophies() async =>
      (await client.league.trophies()).map(LeagueModels.trophy).toList();

  @override
  Future<DuelEntity> challenge(int leagueId, int memberId) async =>
      LeagueModels.duel(await client.duel.challenge(leagueId, memberId));

  @override
  Future<DuelEntity> fetchDuel(int duelId) async =>
      LeagueModels.duel(await client.duel.get(duelId));

  @override
  Future<DuelEntity> playDuelMove(int duelId, app.BattleMove move) async =>
      LeagueModels.duel(
        await client.duel.move(duelId, BattleModel.toProtocolMove(move)),
      );
}

import 'package:bite_buddy/features/streak/data/data_sources/remote/streak_remote_data_source.dart';
import 'package:bite_buddy/features/streak/data/models/streak_models.dart';
import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class StreakRemoteDataSourceImpl implements StreakRemoteDataSource {
  final Client client;

  StreakRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SharedStreakEntity>> fetchStreaks() async =>
      (await client.streak.mine()).map(StreakModels.streak).toList();

  @override
  Future<List<StreakFriendEntity>> fetchCandidates() async =>
      (await client.streak.candidates()).map(StreakModels.friend).toList();

  @override
  Future<SharedStreakEntity> invite(String friendUserId) async =>
      StreakModels.streak(
        await client.streak.invite(UuidValue.fromString(friendUserId)),
      );

  @override
  Future<SharedStreakEntity> accept(int streakId) async =>
      StreakModels.streak(await client.streak.accept(streakId));

  @override
  Future<void> remove(int streakId) => client.streak.remove(streakId);
}

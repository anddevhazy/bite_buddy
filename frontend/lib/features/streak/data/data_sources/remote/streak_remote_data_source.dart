import 'package:bite_buddy/features/streak/domain/entities/streak_entities.dart';

abstract class StreakRemoteDataSource {
  Future<List<SharedStreakEntity>> fetchStreaks();

  Future<List<StreakFriendEntity>> fetchCandidates();

  Future<SharedStreakEntity> invite(String friendUserId);

  Future<SharedStreakEntity> accept(int streakId);

  Future<void> remove(int streakId);
}

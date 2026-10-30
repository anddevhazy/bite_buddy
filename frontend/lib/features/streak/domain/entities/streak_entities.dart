import 'package:equatable/equatable.dart';

enum SharedStreakStatus {
  // Both friends accepted; the streak is running
  active,
  // You sent the invite and are waiting for your friend
  invited,
  // Your friend invited you
  incoming,
}

// A streak kept alive with a friend: a day only counts when you both feed
class SharedStreakEntity extends Equatable {
  final int id;
  final SharedStreakStatus status;
  final String friendPetName;
  final String friendSpeciesKey;
  final int streak;
  final int bestStreak;
  final bool youFedToday;
  final bool friendFedToday;

  const SharedStreakEntity({
    required this.id,
    required this.status,
    required this.friendPetName,
    required this.friendSpeciesKey,
    required this.streak,
    required this.bestStreak,
    required this.youFedToday,
    required this.friendFedToday,
  });

  @override
  List<Object?> get props => [
    id,
    status,
    streak,
    bestStreak,
    youFedToday,
    friendFedToday,
  ];
}

// A league friend you could start a shared streak with
class StreakFriendEntity extends Equatable {
  final String userId;
  final String petName;
  final String speciesKey;

  const StreakFriendEntity({
    required this.userId,
    required this.petName,
    required this.speciesKey,
  });

  @override
  List<Object?> get props => [userId];
}

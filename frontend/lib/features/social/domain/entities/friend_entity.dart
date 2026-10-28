import 'package:equatable/equatable.dart';

enum FriendStatus {
  friends,
  // They asked you; you can accept or decline
  incoming,
  // You asked them; waiting for them to accept
  outgoing,
}

class FriendEntity extends Equatable {
  final int friendshipId;
  final FriendStatus status;
  final int petId;
  final String petName;
  final String speciesKey;
  final int level;
  final int nutrition;
  final int streak;
  // Days in a row you both fed your pets; 0 unless you're friends
  final int sharedStreak;

  const FriendEntity({
    required this.friendshipId,
    required this.status,
    required this.petId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.nutrition,
    required this.streak,
    required this.sharedStreak,
  });

  @override
  List<Object?> get props => [
    friendshipId,
    status,
    petId,
    petName,
    speciesKey,
    level,
    nutrition,
    streak,
    sharedStreak,
  ];
}

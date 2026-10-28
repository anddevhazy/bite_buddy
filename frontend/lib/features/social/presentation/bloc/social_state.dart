part of 'social_cubit.dart';

abstract class SocialState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SocialInitial extends SocialState {}

class SocialLoading extends SocialState {}

class SocialLoaded extends SocialState {
  final String friendCode;
  final List<FriendEntity> friends;
  final List<ChallengeEntity> challenges;
  // True while an add, accept, join etc. is in flight
  final bool busy;

  SocialLoaded({
    required this.friendCode,
    required this.friends,
    required this.challenges,
    this.busy = false,
  });

  SocialLoaded copyWith({bool? busy}) => SocialLoaded(
    friendCode: friendCode,
    friends: friends,
    challenges: challenges,
    busy: busy ?? this.busy,
  );

  @override
  List<Object?> get props => [friendCode, friends, challenges, busy];
}

// Loading failed with nothing to show yet
class SocialFailed extends SocialState {
  final Failure failure;

  SocialFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

// One-off results of an action, shown as a toast. The cubit goes straight
// back to SocialLoaded afterwards.
class SocialActionDone extends SocialState {
  final String message;

  SocialActionDone({required this.message});

  @override
  List<Object?> get props => [message];
}

class SocialActionFailed extends SocialState {
  final Failure failure;

  SocialActionFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}

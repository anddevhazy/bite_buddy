import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy/features/social/domain/entities/challenge_entity.dart';
import 'package:bite_buddy/features/social/domain/entities/friend_entity.dart';
import 'package:bite_buddy/features/social/domain/usecases/accept_friend_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/add_friend_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/create_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_challenges_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_friend_code_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/fetch_friends_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/join_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/leave_challenge_usecase.dart';
import 'package:bite_buddy/features/social/domain/usecases/remove_friend_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  final FetchFriendCodeUseCase fetchFriendCodeUseCase;
  final FetchFriendsUseCase fetchFriendsUseCase;
  final AddFriendUseCase addFriendUseCase;
  final AcceptFriendUseCase acceptFriendUseCase;
  final RemoveFriendUseCase removeFriendUseCase;
  final FetchChallengesUseCase fetchChallengesUseCase;
  final CreateChallengeUseCase createChallengeUseCase;
  final JoinChallengeUseCase joinChallengeUseCase;
  final LeaveChallengeUseCase leaveChallengeUseCase;

  SocialCubit({
    required this.fetchFriendCodeUseCase,
    required this.fetchFriendsUseCase,
    required this.addFriendUseCase,
    required this.acceptFriendUseCase,
    required this.removeFriendUseCase,
    required this.fetchChallengesUseCase,
    required this.createChallengeUseCase,
    required this.joinChallengeUseCase,
    required this.leaveChallengeUseCase,
  }) : super(SocialInitial());

  SocialLoaded? get _loaded => switch (state) {
    SocialLoaded loaded => loaded,
    _ => null,
  };

  Future<void> load() async {
    // Keep showing the old lists while refreshing
    if (_loaded == null) emit(SocialLoading());

    final (codeResult, friendsResult, challengesResult) = await (
      fetchFriendCodeUseCase.call(),
      fetchFriendsUseCase.call(),
      fetchChallengesUseCase.call(),
    ).wait;

    final failure = [
      codeResult,
      friendsResult,
      challengesResult,
    ].map((r) => r.fold((f) => f, (_) => null)).nonNulls.firstOrNull;
    if (failure != null) {
      if (_loaded == null) emit(SocialFailed(failure: failure));
      return;
    }
    emit(
      SocialLoaded(
        friendCode: codeResult.getOrElse(() => ''),
        friends: friendsResult.getOrElse(() => const []),
        challenges: challengesResult.getOrElse(() => const []),
      ),
    );
  }

  Future<void> addFriend(String code) => _act(
    () => addFriendUseCase.call(code),
    (friend) => friend.status == FriendStatus.friends
        ? "You're now friends with ${friend.petName}!"
        : 'Friend request sent to ${friend.petName}',
  );

  Future<void> accept(FriendEntity friend) => _act(
    () => acceptFriendUseCase.call(friend.friendshipId),
    (_) => "You're now friends with ${friend.petName}!",
  );

  Future<void> remove(FriendEntity friend) => _act(
    () => removeFriendUseCase.call(friend.friendshipId),
    (_) => switch (friend.status) {
      FriendStatus.friends => 'Removed ${friend.petName}',
      FriendStatus.incoming => 'Request declined',
      FriendStatus.outgoing => 'Request cancelled',
    },
  );

  Future<void> createChallenge(String name, int days) => _act(
    () => createChallengeUseCase.call(name, days),
    (c) => 'Challenge created! Share the code ${c.code}',
  );

  Future<void> joinChallenge(String code) => _act(
    () => joinChallengeUseCase.call(code),
    (c) => 'You joined ${c.name}!',
  );

  Future<void> leaveChallenge(ChallengeEntity challenge) => _act(
    () => leaveChallengeUseCase.call(challenge.id),
    (_) => 'You left ${challenge.name}',
  );

  void reset() => emit(SocialInitial());

  // Runs one action, reports how it went, then reloads the lists so they
  // match the server
  Future<void> _act<T>(
    Future<Either<Failure, T>> Function() action,
    String Function(T result) successMessage,
  ) async {
    final loaded = _loaded;
    if (loaded == null || loaded.busy) return;
    emit(loaded.copyWith(busy: true));

    final result = await action();
    result.fold(
      (failure) {
        emit(SocialActionFailed(failure: failure));
        emit(loaded);
      },
      (value) {
        emit(SocialActionDone(message: successMessage(value)));
        emit(loaded);
      },
    );
    if (result.isRight()) await load();
  }
}

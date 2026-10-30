/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:bite_buddy_client/src/protocol/activity/activity_sync_result.dart'
    as _iy7hcr3x;
import 'package:bite_buddy_client/src/protocol/arena.dart' as _ih1v9sxu;
import 'package:bite_buddy_client/src/protocol/arena_run_config.dart'
    as _ipde2zlx;
import 'package:bite_buddy_client/src/protocol/arena_run_report.dart'
    as _i6lq1d8e;
import 'package:bite_buddy_client/src/protocol/arena_run_result.dart'
    as _iqi7iz9b;
import 'package:bite_buddy_client/src/protocol/battle_move.dart' as _ih5s12ml;
import 'package:bite_buddy_client/src/protocol/feed_result.dart' as _ik3mz3kd;
import 'package:bite_buddy_client/src/protocol/leaderboard_entry.dart'
    as _iw02fr1r;
import 'package:bite_buddy_client/src/protocol/league/duel_view.dart'
    as _iy1luie2;
import 'package:bite_buddy_client/src/protocol/league/league_detail.dart'
    as _il8zp1zv;
import 'package:bite_buddy_client/src/protocol/league/league_summary.dart'
    as _i4dmvkfy;
import 'package:bite_buddy_client/src/protocol/league/trophy.dart' as _iaaiiecv;
import 'package:bite_buddy_client/src/protocol/meal.dart' as _is4r12e0;
import 'package:bite_buddy_client/src/protocol/meal_suggestion.dart'
    as _i98wybr7;
import 'package:bite_buddy_client/src/protocol/memory/memory_book.dart'
    as _isw9fj5y;
import 'package:bite_buddy_client/src/protocol/nutrition_insights.dart'
    as _iwtty9ju;
import 'package:bite_buddy_client/src/protocol/pet.dart' as _iqjbfwnu;
import 'package:bite_buddy_client/src/protocol/pet_species.dart' as _i12uia3s;
import 'package:bite_buddy_client/src/protocol/portrait/portrait_draft.dart'
    as _i14chipx;
import 'package:bite_buddy_client/src/protocol/streak/streak_buddy_view.dart'
    as _is2ga6uj;
import 'package:bite_buddy_client/src/protocol/streak/streak_friend.dart'
    as _ik6csu2n;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointActivity extends _isc.EndpointRef {
  EndpointActivity(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'activity';

  _ida.Future<_iy7hcr3x.ActivitySyncResult> sync(
    int steps,
    int sleepMinutes,
    int utcOffsetMinutes,
  ) => caller.callServerEndpoint<_iy7hcr3x.ActivitySyncResult>(
    'activity',
    'sync',
    {
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'utcOffsetMinutes': utcOffsetMinutes,
    },
  );
}

/// {@category Endpoint}
class EndpointBattle extends _isc.EndpointRef {
  EndpointBattle(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'battle';

  _ida.Future<_ih1v9sxu.Arena> arena() =>
      caller.callServerEndpoint<_ih1v9sxu.Arena>(
        'battle',
        'arena',
        {},
      );

  _ida.Future<_ipde2zlx.ArenaRunConfig> startRun(String opponentKey) =>
      caller.callServerEndpoint<_ipde2zlx.ArenaRunConfig>(
        'battle',
        'startRun',
        {'opponentKey': opponentKey},
      );

  _ida.Future<_iqi7iz9b.ArenaRunResult> finishRun(
    int runId,
    _i6lq1d8e.ArenaRunReport report,
  ) => caller.callServerEndpoint<_iqi7iz9b.ArenaRunResult>(
    'battle',
    'finishRun',
    {
      'runId': runId,
      'report': report,
    },
  );
}

/// {@category Endpoint}
class EndpointDuel extends _isc.EndpointRef {
  EndpointDuel(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'duel';

  _ida.Future<_iy1luie2.DuelView> challenge(
    int leagueId,
    int opponentMemberId,
  ) => caller.callServerEndpoint<_iy1luie2.DuelView>(
    'duel',
    'challenge',
    {
      'leagueId': leagueId,
      'opponentMemberId': opponentMemberId,
    },
  );

  _ida.Future<_iy1luie2.DuelView> get(int duelId) =>
      caller.callServerEndpoint<_iy1luie2.DuelView>(
        'duel',
        'get',
        {'duelId': duelId},
      );

  _ida.Future<_iy1luie2.DuelView> move(
    int duelId,
    _ih5s12ml.BattleMove move,
  ) => caller.callServerEndpoint<_iy1luie2.DuelView>(
    'duel',
    'move',
    {
      'duelId': duelId,
      'move': move,
    },
  );
}

/// {@category Endpoint}
class EndpointLeaderboard extends _isc.EndpointRef {
  EndpointLeaderboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'leaderboard';

  _ida.Future<List<_iw02fr1r.LeaderboardEntry>> top() =>
      caller.callServerEndpoint<List<_iw02fr1r.LeaderboardEntry>>(
        'leaderboard',
        'top',
        {},
      );
}

/// {@category Endpoint}
class EndpointLeague extends _isc.EndpointRef {
  EndpointLeague(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'league';

  _ida.Future<List<_i4dmvkfy.LeagueSummary>> myLeagues() =>
      caller.callServerEndpoint<List<_i4dmvkfy.LeagueSummary>>(
        'league',
        'myLeagues',
        {},
      );

  _ida.Future<_il8zp1zv.LeagueDetail> create(String name) =>
      caller.callServerEndpoint<_il8zp1zv.LeagueDetail>(
        'league',
        'create',
        {'name': name},
      );

  _ida.Future<_il8zp1zv.LeagueDetail> join(String inviteCode) =>
      caller.callServerEndpoint<_il8zp1zv.LeagueDetail>(
        'league',
        'join',
        {'inviteCode': inviteCode},
      );

  _ida.Future<_il8zp1zv.LeagueDetail> detail(int leagueId) =>
      caller.callServerEndpoint<_il8zp1zv.LeagueDetail>(
        'league',
        'detail',
        {'leagueId': leagueId},
      );

  _ida.Future<void> leave(int leagueId) => caller.callServerEndpoint<void>(
    'league',
    'leave',
    {'leagueId': leagueId},
  );

  _ida.Future<List<_iaaiiecv.Trophy>> trophies() =>
      caller.callServerEndpoint<List<_iaaiiecv.Trophy>>(
        'league',
        'trophies',
        {},
      );
}

/// {@category Endpoint}
class EndpointMeal extends _isc.EndpointRef {
  EndpointMeal(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'meal';

  _ida.Future<_is4r12e0.Meal> analyze(_idt.ByteData image) =>
      caller.callServerEndpoint<_is4r12e0.Meal>(
        'meal',
        'analyze',
        {'image': image},
      );

  _ida.Future<_ik3mz3kd.FeedResult> feed(
    int mealId,
    int utcOffsetMinutes,
  ) => caller.callServerEndpoint<_ik3mz3kd.FeedResult>(
    'meal',
    'feed',
    {
      'mealId': mealId,
      'utcOffsetMinutes': utcOffsetMinutes,
    },
  );

  _ida.Future<List<_is4r12e0.Meal>> history() =>
      caller.callServerEndpoint<List<_is4r12e0.Meal>>(
        'meal',
        'history',
        {},
      );

  _ida.Future<_iwtty9ju.NutritionInsights> insights() =>
      caller.callServerEndpoint<_iwtty9ju.NutritionInsights>(
        'meal',
        'insights',
        {},
      );

  _ida.Future<List<_i98wybr7.MealSuggestion>> ideas(String locale) =>
      caller.callServerEndpoint<List<_i98wybr7.MealSuggestion>>(
        'meal',
        'ideas',
        {'locale': locale},
      );
}

/// {@category Endpoint}
class EndpointMemory extends _isc.EndpointRef {
  EndpointMemory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'memory';

  _ida.Future<_isw9fj5y.MemoryBook> book() =>
      caller.callServerEndpoint<_isw9fj5y.MemoryBook>(
        'memory',
        'book',
        {},
      );
}

/// {@category Endpoint}
class EndpointPet extends _isc.EndpointRef {
  EndpointPet(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pet';

  _ida.Future<List<_i12uia3s.PetSpecies>> listSpecies() =>
      caller.callServerEndpoint<List<_i12uia3s.PetSpecies>>(
        'pet',
        'listSpecies',
        {},
      );

  _ida.Future<_iqjbfwnu.Pet?> getMyPet() =>
      caller.callServerEndpoint<_iqjbfwnu.Pet?>(
        'pet',
        'getMyPet',
        {},
      );

  _ida.Future<_iqjbfwnu.Pet> adopt(
    String speciesKey,
    String name,
  ) => caller.callServerEndpoint<_iqjbfwnu.Pet>(
    'pet',
    'adopt',
    {
      'speciesKey': speciesKey,
      'name': name,
    },
  );
}

/// {@category Endpoint}
class EndpointPortrait extends _isc.EndpointRef {
  EndpointPortrait(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'portrait';

  _ida.Future<_i14chipx.PortraitDraft> create(_idt.ByteData photo) =>
      caller.callServerEndpoint<_i14chipx.PortraitDraft>(
        'portrait',
        'create',
        {'photo': photo},
      );

  _ida.Future<_iqjbfwnu.Pet> adopt(
    int portraitId,
    String name,
  ) => caller.callServerEndpoint<_iqjbfwnu.Pet>(
    'portrait',
    'adopt',
    {
      'portraitId': portraitId,
      'name': name,
    },
  );

  _ida.Future<_idt.ByteData> image(int portraitId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'portrait',
        'image',
        {'portraitId': portraitId},
      );
}

/// {@category Endpoint}
class EndpointStreak extends _isc.EndpointRef {
  EndpointStreak(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'streak';

  _ida.Future<List<_is2ga6uj.StreakBuddyView>> mine() =>
      caller.callServerEndpoint<List<_is2ga6uj.StreakBuddyView>>(
        'streak',
        'mine',
        {},
      );

  _ida.Future<List<_ik6csu2n.StreakFriend>> candidates() =>
      caller.callServerEndpoint<List<_ik6csu2n.StreakFriend>>(
        'streak',
        'candidates',
        {},
      );

  _ida.Future<_is2ga6uj.StreakBuddyView> invite(_isc.UuidValue friendUserId) =>
      caller.callServerEndpoint<_is2ga6uj.StreakBuddyView>(
        'streak',
        'invite',
        {'friendUserId': friendUserId},
      );

  _ida.Future<_is2ga6uj.StreakBuddyView> accept(int streakId) =>
      caller.callServerEndpoint<_is2ga6uj.StreakBuddyView>(
        'streak',
        'accept',
        {'streakId': streakId},
      );

  _ida.Future<void> remove(int streakId) => caller.callServerEndpoint<void>(
    'streak',
    'remove',
    {'streakId': streakId},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    activity = EndpointActivity(this);
    battle = EndpointBattle(this);
    duel = EndpointDuel(this);
    leaderboard = EndpointLeaderboard(this);
    league = EndpointLeague(this);
    meal = EndpointMeal(this);
    memory = EndpointMemory(this);
    pet = EndpointPet(this);
    portrait = EndpointPortrait(this);
    streak = EndpointStreak(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointActivity activity;

  late final EndpointBattle battle;

  late final EndpointDuel duel;

  late final EndpointLeaderboard leaderboard;

  late final EndpointLeague league;

  late final EndpointMeal meal;

  late final EndpointMemory memory;

  late final EndpointPet pet;

  late final EndpointPortrait portrait;

  late final EndpointStreak streak;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'activity': activity,
    'battle': battle,
    'duel': duel,
    'leaderboard': leaderboard,
    'league': league,
    'meal': meal,
    'memory': memory,
    'pet': pet,
    'portrait': portrait,
    'streak': streak,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}

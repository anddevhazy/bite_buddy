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
import 'dart:typed_data' as _idt;
import 'package:bite_buddy_server/src/generated/arena_run_report.dart'
    as _iipal77g;
import 'package:bite_buddy_server/src/generated/battle_move.dart' as _itk175y8;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/activity_endpoint.dart' as _ijhtbkuk;
import '../endpoints/battle_endpoint.dart' as _ilghbeth;
import '../endpoints/duel_endpoint.dart' as _iq9xj8m5;
import '../endpoints/leaderboard_endpoint.dart' as _iy80ldha;
import '../endpoints/league_endpoint.dart' as _ixxtv0ct;
import '../endpoints/meal_endpoint.dart' as _indvr2gf;
import '../endpoints/memory_endpoint.dart' as _i0ojblse;
import '../endpoints/pet_endpoint.dart' as _ic7gura5;
import '../endpoints/portrait_endpoint.dart' as _ipr4708j;
import '../endpoints/streak_endpoint.dart' as _ii2s5alo;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'activity': _ijhtbkuk.ActivityEndpoint()
        ..initialize(
          server,
          'activity',
          null,
        ),
      'battle': _ilghbeth.BattleEndpoint()
        ..initialize(
          server,
          'battle',
          null,
        ),
      'duel': _iq9xj8m5.DuelEndpoint()
        ..initialize(
          server,
          'duel',
          null,
        ),
      'leaderboard': _iy80ldha.LeaderboardEndpoint()
        ..initialize(
          server,
          'leaderboard',
          null,
        ),
      'league': _ixxtv0ct.LeagueEndpoint()
        ..initialize(
          server,
          'league',
          null,
        ),
      'meal': _indvr2gf.MealEndpoint()
        ..initialize(
          server,
          'meal',
          null,
        ),
      'memory': _i0ojblse.MemoryEndpoint()
        ..initialize(
          server,
          'memory',
          null,
        ),
      'pet': _ic7gura5.PetEndpoint()
        ..initialize(
          server,
          'pet',
          null,
        ),
      'portrait': _ipr4708j.PortraitEndpoint()
        ..initialize(
          server,
          'portrait',
          null,
        ),
      'streak': _ii2s5alo.StreakEndpoint()
        ..initialize(
          server,
          'streak',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['activity'] = _is.EndpointConnector(
      name: 'activity',
      endpoint: endpoints['activity']!,
      methodConnectors: {
        'sync': _is.MethodConnector(
          name: 'sync',
          params: {
            'steps': _is.ParameterDescription(
              name: 'steps',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'sleepMinutes': _is.ParameterDescription(
              name: 'sleepMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _is.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['activity'] as _ijhtbkuk.ActivityEndpoint).sync(
                    session,
                    params['steps'],
                    params['sleepMinutes'],
                    params['utcOffsetMinutes'],
                  ),
        ),
      },
    );
    connectors['battle'] = _is.EndpointConnector(
      name: 'battle',
      endpoint: endpoints['battle']!,
      methodConnectors: {
        'arena': _is.MethodConnector(
          name: 'arena',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['battle'] as _ilghbeth.BattleEndpoint)
                  .arena(session),
        ),
        'startRun': _is.MethodConnector(
          name: 'startRun',
          params: {
            'opponentKey': _is.ParameterDescription(
              name: 'opponentKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['battle'] as _ilghbeth.BattleEndpoint).startRun(
                    session,
                    params['opponentKey'],
                  ),
        ),
        'finishRun': _is.MethodConnector(
          name: 'finishRun',
          params: {
            'runId': _is.ParameterDescription(
              name: 'runId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'report': _is.ParameterDescription(
              name: 'report',
              type: _is.getType<_iipal77g.ArenaRunReport>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['battle'] as _ilghbeth.BattleEndpoint).finishRun(
                    session,
                    params['runId'],
                    params['report'],
                  ),
        ),
      },
    );
    connectors['duel'] = _is.EndpointConnector(
      name: 'duel',
      endpoint: endpoints['duel']!,
      methodConnectors: {
        'challenge': _is.MethodConnector(
          name: 'challenge',
          params: {
            'leagueId': _is.ParameterDescription(
              name: 'leagueId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'opponentMemberId': _is.ParameterDescription(
              name: 'opponentMemberId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['duel'] as _iq9xj8m5.DuelEndpoint).challenge(
                    session,
                    params['leagueId'],
                    params['opponentMemberId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'duelId': _is.ParameterDescription(
              name: 'duelId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['duel'] as _iq9xj8m5.DuelEndpoint).get(
                session,
                params['duelId'],
              ),
        ),
        'move': _is.MethodConnector(
          name: 'move',
          params: {
            'duelId': _is.ParameterDescription(
              name: 'duelId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'move': _is.ParameterDescription(
              name: 'move',
              type: _is.getType<_itk175y8.BattleMove>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['duel'] as _iq9xj8m5.DuelEndpoint).move(
                session,
                params['duelId'],
                params['move'],
              ),
        ),
      },
    );
    connectors['leaderboard'] = _is.EndpointConnector(
      name: 'leaderboard',
      endpoint: endpoints['leaderboard']!,
      methodConnectors: {
        'top': _is.MethodConnector(
          name: 'top',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['leaderboard'] as _iy80ldha.LeaderboardEndpoint)
                      .top(session),
        ),
      },
    );
    connectors['league'] = _is.EndpointConnector(
      name: 'league',
      endpoint: endpoints['league']!,
      methodConnectors: {
        'myLeagues': _is.MethodConnector(
          name: 'myLeagues',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _ixxtv0ct.LeagueEndpoint)
                  .myLeagues(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['league'] as _ixxtv0ct.LeagueEndpoint).create(
                    session,
                    params['name'],
                  ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'inviteCode': _is.ParameterDescription(
              name: 'inviteCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _ixxtv0ct.LeagueEndpoint).join(
                session,
                params['inviteCode'],
              ),
        ),
        'detail': _is.MethodConnector(
          name: 'detail',
          params: {
            'leagueId': _is.ParameterDescription(
              name: 'leagueId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['league'] as _ixxtv0ct.LeagueEndpoint).detail(
                    session,
                    params['leagueId'],
                  ),
        ),
        'leave': _is.MethodConnector(
          name: 'leave',
          params: {
            'leagueId': _is.ParameterDescription(
              name: 'leagueId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['league'] as _ixxtv0ct.LeagueEndpoint).leave(
                    session,
                    params['leagueId'],
                  ),
        ),
        'trophies': _is.MethodConnector(
          name: 'trophies',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _ixxtv0ct.LeagueEndpoint)
                  .trophies(session),
        ),
      },
    );
    connectors['meal'] = _is.EndpointConnector(
      name: 'meal',
      endpoint: endpoints['meal']!,
      methodConnectors: {
        'analyze': _is.MethodConnector(
          name: 'analyze',
          params: {
            'image': _is.ParameterDescription(
              name: 'image',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _indvr2gf.MealEndpoint).analyze(
                session,
                params['image'],
              ),
        ),
        'feed': _is.MethodConnector(
          name: 'feed',
          params: {
            'mealId': _is.ParameterDescription(
              name: 'mealId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _is.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _indvr2gf.MealEndpoint).feed(
                session,
                params['mealId'],
                params['utcOffsetMinutes'],
              ),
        ),
        'history': _is.MethodConnector(
          name: 'history',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _indvr2gf.MealEndpoint).history(
                session,
              ),
        ),
        'insights': _is.MethodConnector(
          name: 'insights',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _indvr2gf.MealEndpoint).insights(
                session,
              ),
        ),
        'ideas': _is.MethodConnector(
          name: 'ideas',
          params: {
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['meal'] as _indvr2gf.MealEndpoint).ideas(
                session,
                params['locale'],
              ),
        ),
      },
    );
    connectors['memory'] = _is.EndpointConnector(
      name: 'memory',
      endpoint: endpoints['memory']!,
      methodConnectors: {
        'book': _is.MethodConnector(
          name: 'book',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _i0ojblse.MemoryEndpoint).book(
                session,
              ),
        ),
      },
    );
    connectors['pet'] = _is.EndpointConnector(
      name: 'pet',
      endpoint: endpoints['pet']!,
      methodConnectors: {
        'listSpecies': _is.MethodConnector(
          name: 'listSpecies',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pet'] as _ic7gura5.PetEndpoint)
                  .listSpecies(session),
        ),
        'getMyPet': _is.MethodConnector(
          name: 'getMyPet',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['pet'] as _ic7gura5.PetEndpoint).getMyPet(session),
        ),
        'adopt': _is.MethodConnector(
          name: 'adopt',
          params: {
            'speciesKey': _is.ParameterDescription(
              name: 'speciesKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pet'] as _ic7gura5.PetEndpoint).adopt(
                session,
                params['speciesKey'],
                params['name'],
              ),
        ),
      },
    );
    connectors['portrait'] = _is.EndpointConnector(
      name: 'portrait',
      endpoint: endpoints['portrait']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'photo': _is.ParameterDescription(
              name: 'photo',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['portrait'] as _ipr4708j.PortraitEndpoint).create(
                    session,
                    params['photo'],
                  ),
        ),
        'adopt': _is.MethodConnector(
          name: 'adopt',
          params: {
            'portraitId': _is.ParameterDescription(
              name: 'portraitId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['portrait'] as _ipr4708j.PortraitEndpoint).adopt(
                    session,
                    params['portraitId'],
                    params['name'],
                  ),
        ),
        'image': _is.MethodConnector(
          name: 'image',
          params: {
            'portraitId': _is.ParameterDescription(
              name: 'portraitId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['portrait'] as _ipr4708j.PortraitEndpoint).image(
                    session,
                    params['portraitId'],
                  ),
        ),
      },
    );
    connectors['streak'] = _is.EndpointConnector(
      name: 'streak',
      endpoint: endpoints['streak']!,
      methodConnectors: {
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['streak'] as _ii2s5alo.StreakEndpoint).mine(
                session,
              ),
        ),
        'candidates': _is.MethodConnector(
          name: 'candidates',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['streak'] as _ii2s5alo.StreakEndpoint)
                  .candidates(session),
        ),
        'invite': _is.MethodConnector(
          name: 'invite',
          params: {
            'friendUserId': _is.ParameterDescription(
              name: 'friendUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['streak'] as _ii2s5alo.StreakEndpoint).invite(
                    session,
                    params['friendUserId'],
                  ),
        ),
        'accept': _is.MethodConnector(
          name: 'accept',
          params: {
            'streakId': _is.ParameterDescription(
              name: 'streakId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['streak'] as _ii2s5alo.StreakEndpoint).accept(
                    session,
                    params['streakId'],
                  ),
        ),
        'remove': _is.MethodConnector(
          name: 'remove',
          params: {
            'streakId': _is.ParameterDescription(
              name: 'streakId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['streak'] as _ii2s5alo.StreakEndpoint).remove(
                    session,
                    params['streakId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}

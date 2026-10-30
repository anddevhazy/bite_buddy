/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bite_buddy_server/src/generated/leaderboard_entry.dart'
    as _i5n4mhlw;
import 'package:bite_buddy_server/src/generated/league/league_summary.dart'
    as _iol6rmxl;
import 'package:bite_buddy_server/src/generated/league/trophy.dart'
    as _i17xpjnn;
import 'package:bite_buddy_server/src/generated/meal.dart' as _idk4xbnt;
import 'package:bite_buddy_server/src/generated/meal_suggestion.dart'
    as _ipo9v88q;
import 'package:bite_buddy_server/src/generated/pet_species.dart' as _it8ve0l0;
import 'package:bite_buddy_server/src/generated/streak/streak_buddy_view.dart'
    as _iaktjz74;
import 'package:bite_buddy_server/src/generated/streak/streak_friend.dart'
    as _ic1heu54;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'activity/activity_day.dart' as _igd8tknp;
import 'activity/activity_sync_result.dart' as _i2m60d3i;
import 'arena.dart' as _iwiby7qv;
import 'arena_rules.dart' as _ildu9ri2;
import 'arena_run.dart' as _isxurcys;
import 'arena_run_config.dart' as _ifo8s6zf;
import 'arena_run_report.dart' as _i541vp0l;
import 'arena_run_result.dart' as _ih8kl9mf;
import 'arena_run_status.dart' as _ic5j8p21;
import 'battle_move.dart' as _iz303hum;
import 'battle_stats.dart' as _ievndlqk;
import 'errors/bite_buddy_exception.dart' as _in42pmv9;
import 'feed_result.dart' as _i6546n9y;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'league/duel.dart' as _i4ouuzm2;
import 'league/duel_round.dart' as _i9ikuwzg;
import 'league/duel_round_view.dart' as _iwzwahda;
import 'league/duel_status.dart' as _i1rc3le2;
import 'league/duel_view.dart' as _ihf53btn;
import 'league/league.dart' as _iu6wab7g;
import 'league/league_challenge.dart' as _it8j4sh6;
import 'league/league_detail.dart' as _i535uegq;
import 'league/league_member.dart' as _ixajhlyi;
import 'league/league_standing.dart' as _itpdgapo;
import 'league/league_summary.dart' as _idqobzdi;
import 'league/season_result.dart' as _i7znqzmr;
import 'league/trophy.dart' as _ij1ocmo2;
import 'meal.dart' as _ixnoudrx;
import 'meal_ideas.dart' as _igmlprfo;
import 'meal_suggestion.dart' as _iymppxeh;
import 'nutrition_insights.dart' as _ik434gbd;
import 'opponent.dart' as _i2ot5zrj;
import 'pet.dart' as _ie9pyd3w;
import 'pet_species.dart' as _it7bnlgl;
import 'portrait/pet_portrait.dart' as _i1jr9gvy;
import 'portrait/portrait_draft.dart' as _ijnz0svl;
import 'streak/streak_buddy.dart' as _igrz7ax7;
import 'streak/streak_buddy_status.dart' as _io8ln7w8;
import 'streak/streak_buddy_view.dart' as _i5rddhms;
import 'streak/streak_friend.dart' as _ifaru43m;
export 'activity/activity_day.dart';
export 'activity/activity_sync_result.dart';
export 'arena.dart';
export 'arena_rules.dart';
export 'arena_run.dart';
export 'arena_run_config.dart';
export 'arena_run_report.dart';
export 'arena_run_result.dart';
export 'arena_run_status.dart';
export 'battle_move.dart';
export 'battle_stats.dart';
export 'errors/bite_buddy_exception.dart';
export 'feed_result.dart';
export 'leaderboard_entry.dart';
export 'league/duel.dart';
export 'league/duel_round.dart';
export 'league/duel_round_view.dart';
export 'league/duel_status.dart';
export 'league/duel_view.dart';
export 'league/league.dart';
export 'league/league_challenge.dart';
export 'league/league_detail.dart';
export 'league/league_member.dart';
export 'league/league_standing.dart';
export 'league/league_summary.dart';
export 'league/season_result.dart';
export 'league/trophy.dart';
export 'meal.dart';
export 'meal_ideas.dart';
export 'meal_suggestion.dart';
export 'nutrition_insights.dart';
export 'opponent.dart';
export 'pet.dart';
export 'pet_species.dart';
export 'portrait/pet_portrait.dart';
export 'portrait/portrait_draft.dart';
export 'streak/streak_buddy.dart';
export 'streak/streak_buddy_status.dart';
export 'streak/streak_buddy_view.dart';
export 'streak/streak_friend.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'activity_day',
      dartName: 'ActivityDay',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'day',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'steps',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'sleepMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'energyAwarded',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'healthAwarded',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'activity_day_owner_day_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'day',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'arena_run',
      dartName: 'ArenaRun',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'petId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'opponentKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'petMaxHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'petAttack',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'petDefense',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ArenaRunStatus',
        ),
        _isp.ColumnDefinition(
          name: 'finishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'durationMs',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'damageDealt',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'damageTaken',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'verified',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'coinsEarned',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'xpEarned',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'energyChange',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'arena_run_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'duel',
      dartName: 'Duel',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'leagueId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'weekStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'aUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'bUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'aPetName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bPetName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'aSpeciesKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bSpeciesKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'aPortraitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'bPortraitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'aMaxHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bMaxHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aAttack',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bAttack',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aDefense',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bDefense',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aSpecialCooldown',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bSpecialCooldown',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aMove',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:BattleMove?',
        ),
        _isp.ColumnDefinition(
          name: 'bMove',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:BattleMove?',
        ),
        _isp.ColumnDefinition(
          name: 'aMissed',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bMissed',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aHistory',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:BattleMove?>',
        ),
        _isp.ColumnDefinition(
          name: 'bHistory',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:BattleMove?>',
        ),
        _isp.ColumnDefinition(
          name: 'round',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'roundDeadline',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DuelStatus',
        ),
        _isp.ColumnDefinition(
          name: 'winnerUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'endReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'lastRound',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:DuelRound?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'finishedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'duel_league_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'leagueId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'duel_a_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'aUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'duel_b_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'league',
      dartName: 'League',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'league_invite_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'league_member',
      dartName: 'LeagueMember',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'leagueId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'league_member_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'leagueId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'league_member_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'meal',
      dartName: 'Meal',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'calories',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'proteinPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'carbsPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'fatsPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'vitaminsPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'mineralsPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'fiberPct',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'healthScore',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'grade',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'imageHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'photoFingerprint',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'fed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'meal_owner_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'meal_image_hash_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'imageHash',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'meal_ideas',
      dartName: 'MealIdeas',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'day',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'ideas',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:MealSuggestion>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'meal_ideas_owner_day_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'day',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'pet',
      dartName: 'Pet',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'speciesKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'portraitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'xp',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'health',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'energy',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'nutrition',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'coins',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'mealsEaten',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'wins',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'losses',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'lastFedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'streak',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'bestStreak',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'lastStreakDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'utcOffsetMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'lastDecayAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'pet_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'pet_nutrition_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'nutrition',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'pet_portrait',
      dartName: 'PetPortrait',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'image',
          columnType: _isp.ColumnType.bytea,
          isNullable: false,
          dartType: 'dart:typed_data:ByteData',
        ),
        _isp.ColumnDefinition(
          name: 'animal',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'used',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'pet_portrait_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'season_result',
      dartName: 'SeasonResult',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'leagueId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'weekStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'winnerUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'standings',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:LeagueStanding>',
        ),
        _isp.ColumnDefinition(
          name: 'challengeCompleted',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'season_result_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'leagueId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'weekStart',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'streak_buddy',
      dartName: 'StreakBuddy',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'aUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'bUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'accepted',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'streak',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'bestStreak',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'aLastFedDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'bLastFedDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastStreakDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'streak_buddy_pair_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'aUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'streak_buddy_b_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'bUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'trophy',
      dartName: 'Trophy',
      schema: 'public',
      module: 'bite_buddy',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'leagueId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'leagueName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'weekStart',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'score',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'trophy_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _igd8tknp.ActivityDay) {
      return _igd8tknp.ActivityDay.fromJson(data) as T;
    }
    if (t == _i2m60d3i.ActivitySyncResult) {
      return _i2m60d3i.ActivitySyncResult.fromJson(data) as T;
    }
    if (t == _iwiby7qv.Arena) {
      return _iwiby7qv.Arena.fromJson(data) as T;
    }
    if (t == _ildu9ri2.ArenaRules) {
      return _ildu9ri2.ArenaRules.fromJson(data) as T;
    }
    if (t == _isxurcys.ArenaRun) {
      return _isxurcys.ArenaRun.fromJson(data) as T;
    }
    if (t == _ifo8s6zf.ArenaRunConfig) {
      return _ifo8s6zf.ArenaRunConfig.fromJson(data) as T;
    }
    if (t == _i541vp0l.ArenaRunReport) {
      return _i541vp0l.ArenaRunReport.fromJson(data) as T;
    }
    if (t == _ih8kl9mf.ArenaRunResult) {
      return _ih8kl9mf.ArenaRunResult.fromJson(data) as T;
    }
    if (t == _ic5j8p21.ArenaRunStatus) {
      return _ic5j8p21.ArenaRunStatus.fromJson(data) as T;
    }
    if (t == _iz303hum.BattleMove) {
      return _iz303hum.BattleMove.fromJson(data) as T;
    }
    if (t == _ievndlqk.BattleStats) {
      return _ievndlqk.BattleStats.fromJson(data) as T;
    }
    if (t == _in42pmv9.BiteBuddyException) {
      return _in42pmv9.BiteBuddyException.fromJson(data) as T;
    }
    if (t == _i6546n9y.FeedResult) {
      return _i6546n9y.FeedResult.fromJson(data) as T;
    }
    if (t == _ikawkn1p.LeaderboardEntry) {
      return _ikawkn1p.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i4ouuzm2.Duel) {
      return _i4ouuzm2.Duel.fromJson(data) as T;
    }
    if (t == _i9ikuwzg.DuelRound) {
      return _i9ikuwzg.DuelRound.fromJson(data) as T;
    }
    if (t == _iwzwahda.DuelRoundView) {
      return _iwzwahda.DuelRoundView.fromJson(data) as T;
    }
    if (t == _i1rc3le2.DuelStatus) {
      return _i1rc3le2.DuelStatus.fromJson(data) as T;
    }
    if (t == _ihf53btn.DuelView) {
      return _ihf53btn.DuelView.fromJson(data) as T;
    }
    if (t == _iu6wab7g.League) {
      return _iu6wab7g.League.fromJson(data) as T;
    }
    if (t == _it8j4sh6.LeagueChallenge) {
      return _it8j4sh6.LeagueChallenge.fromJson(data) as T;
    }
    if (t == _i535uegq.LeagueDetail) {
      return _i535uegq.LeagueDetail.fromJson(data) as T;
    }
    if (t == _ixajhlyi.LeagueMember) {
      return _ixajhlyi.LeagueMember.fromJson(data) as T;
    }
    if (t == _itpdgapo.LeagueStanding) {
      return _itpdgapo.LeagueStanding.fromJson(data) as T;
    }
    if (t == _idqobzdi.LeagueSummary) {
      return _idqobzdi.LeagueSummary.fromJson(data) as T;
    }
    if (t == _i7znqzmr.SeasonResult) {
      return _i7znqzmr.SeasonResult.fromJson(data) as T;
    }
    if (t == _ij1ocmo2.Trophy) {
      return _ij1ocmo2.Trophy.fromJson(data) as T;
    }
    if (t == _ixnoudrx.Meal) {
      return _ixnoudrx.Meal.fromJson(data) as T;
    }
    if (t == _igmlprfo.MealIdeas) {
      return _igmlprfo.MealIdeas.fromJson(data) as T;
    }
    if (t == _iymppxeh.MealSuggestion) {
      return _iymppxeh.MealSuggestion.fromJson(data) as T;
    }
    if (t == _ik434gbd.NutritionInsights) {
      return _ik434gbd.NutritionInsights.fromJson(data) as T;
    }
    if (t == _i2ot5zrj.Opponent) {
      return _i2ot5zrj.Opponent.fromJson(data) as T;
    }
    if (t == _ie9pyd3w.Pet) {
      return _ie9pyd3w.Pet.fromJson(data) as T;
    }
    if (t == _it7bnlgl.PetSpecies) {
      return _it7bnlgl.PetSpecies.fromJson(data) as T;
    }
    if (t == _i1jr9gvy.PetPortrait) {
      return _i1jr9gvy.PetPortrait.fromJson(data) as T;
    }
    if (t == _ijnz0svl.PortraitDraft) {
      return _ijnz0svl.PortraitDraft.fromJson(data) as T;
    }
    if (t == _igrz7ax7.StreakBuddy) {
      return _igrz7ax7.StreakBuddy.fromJson(data) as T;
    }
    if (t == _io8ln7w8.StreakBuddyStatus) {
      return _io8ln7w8.StreakBuddyStatus.fromJson(data) as T;
    }
    if (t == _i5rddhms.StreakBuddyView) {
      return _i5rddhms.StreakBuddyView.fromJson(data) as T;
    }
    if (t == _ifaru43m.StreakFriend) {
      return _ifaru43m.StreakFriend.fromJson(data) as T;
    }
    if (t == _is.getType<_igd8tknp.ActivityDay?>()) {
      return (data != null ? _igd8tknp.ActivityDay.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2m60d3i.ActivitySyncResult?>()) {
      return (data != null ? _i2m60d3i.ActivitySyncResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwiby7qv.Arena?>()) {
      return (data != null ? _iwiby7qv.Arena.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ildu9ri2.ArenaRules?>()) {
      return (data != null ? _ildu9ri2.ArenaRules.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isxurcys.ArenaRun?>()) {
      return (data != null ? _isxurcys.ArenaRun.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifo8s6zf.ArenaRunConfig?>()) {
      return (data != null ? _ifo8s6zf.ArenaRunConfig.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i541vp0l.ArenaRunReport?>()) {
      return (data != null ? _i541vp0l.ArenaRunReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ih8kl9mf.ArenaRunResult?>()) {
      return (data != null ? _ih8kl9mf.ArenaRunResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ic5j8p21.ArenaRunStatus?>()) {
      return (data != null ? _ic5j8p21.ArenaRunStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz303hum.BattleMove?>()) {
      return (data != null ? _iz303hum.BattleMove.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ievndlqk.BattleStats?>()) {
      return (data != null ? _ievndlqk.BattleStats.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in42pmv9.BiteBuddyException?>()) {
      return (data != null ? _in42pmv9.BiteBuddyException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6546n9y.FeedResult?>()) {
      return (data != null ? _i6546n9y.FeedResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4ouuzm2.Duel?>()) {
      return (data != null ? _i4ouuzm2.Duel.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9ikuwzg.DuelRound?>()) {
      return (data != null ? _i9ikuwzg.DuelRound.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwzwahda.DuelRoundView?>()) {
      return (data != null ? _iwzwahda.DuelRoundView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1rc3le2.DuelStatus?>()) {
      return (data != null ? _i1rc3le2.DuelStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihf53btn.DuelView?>()) {
      return (data != null ? _ihf53btn.DuelView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu6wab7g.League?>()) {
      return (data != null ? _iu6wab7g.League.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_it8j4sh6.LeagueChallenge?>()) {
      return (data != null ? _it8j4sh6.LeagueChallenge.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i535uegq.LeagueDetail?>()) {
      return (data != null ? _i535uegq.LeagueDetail.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixajhlyi.LeagueMember?>()) {
      return (data != null ? _ixajhlyi.LeagueMember.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itpdgapo.LeagueStanding?>()) {
      return (data != null ? _itpdgapo.LeagueStanding.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idqobzdi.LeagueSummary?>()) {
      return (data != null ? _idqobzdi.LeagueSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7znqzmr.SeasonResult?>()) {
      return (data != null ? _i7znqzmr.SeasonResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ij1ocmo2.Trophy?>()) {
      return (data != null ? _ij1ocmo2.Trophy.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixnoudrx.Meal?>()) {
      return (data != null ? _ixnoudrx.Meal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igmlprfo.MealIdeas?>()) {
      return (data != null ? _igmlprfo.MealIdeas.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iymppxeh.MealSuggestion?>()) {
      return (data != null ? _iymppxeh.MealSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik434gbd.NutritionInsights?>()) {
      return (data != null ? _ik434gbd.NutritionInsights.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2ot5zrj.Opponent?>()) {
      return (data != null ? _i2ot5zrj.Opponent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ie9pyd3w.Pet?>()) {
      return (data != null ? _ie9pyd3w.Pet.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_it7bnlgl.PetSpecies?>()) {
      return (data != null ? _it7bnlgl.PetSpecies.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1jr9gvy.PetPortrait?>()) {
      return (data != null ? _i1jr9gvy.PetPortrait.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijnz0svl.PortraitDraft?>()) {
      return (data != null ? _ijnz0svl.PortraitDraft.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igrz7ax7.StreakBuddy?>()) {
      return (data != null ? _igrz7ax7.StreakBuddy.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_io8ln7w8.StreakBuddyStatus?>()) {
      return (data != null ? _io8ln7w8.StreakBuddyStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5rddhms.StreakBuddyView?>()) {
      return (data != null ? _i5rddhms.StreakBuddyView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifaru43m.StreakFriend?>()) {
      return (data != null ? _ifaru43m.StreakFriend.fromJson(data) : null) as T;
    }
    if (t == List<_i2ot5zrj.Opponent>) {
      return (data as List)
              .map((e) => deserialize<_i2ot5zrj.Opponent>(e))
              .toList()
          as T;
    }
    if (t == List<_iz303hum.BattleMove?>) {
      return (data as List)
              .map((e) => deserialize<_iz303hum.BattleMove?>(e))
              .toList()
          as T;
    }
    if (t == List<_itpdgapo.LeagueStanding>) {
      return (data as List)
              .map((e) => deserialize<_itpdgapo.LeagueStanding>(e))
              .toList()
          as T;
    }
    if (t == List<_ihf53btn.DuelView>) {
      return (data as List)
              .map((e) => deserialize<_ihf53btn.DuelView>(e))
              .toList()
          as T;
    }
    if (t == List<_iymppxeh.MealSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_iymppxeh.MealSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i5n4mhlw.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_i5n4mhlw.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_iol6rmxl.LeagueSummary>) {
      return (data as List)
              .map((e) => deserialize<_iol6rmxl.LeagueSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i17xpjnn.Trophy>) {
      return (data as List)
              .map((e) => deserialize<_i17xpjnn.Trophy>(e))
              .toList()
          as T;
    }
    if (t == List<_idk4xbnt.Meal>) {
      return (data as List).map((e) => deserialize<_idk4xbnt.Meal>(e)).toList()
          as T;
    }
    if (t == List<_ipo9v88q.MealSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_ipo9v88q.MealSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_it8ve0l0.PetSpecies>) {
      return (data as List)
              .map((e) => deserialize<_it8ve0l0.PetSpecies>(e))
              .toList()
          as T;
    }
    if (t == List<_iaktjz74.StreakBuddyView>) {
      return (data as List)
              .map((e) => deserialize<_iaktjz74.StreakBuddyView>(e))
              .toList()
          as T;
    }
    if (t == List<_ic1heu54.StreakFriend>) {
      return (data as List)
              .map((e) => deserialize<_ic1heu54.StreakFriend>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _igd8tknp.ActivityDay => 'ActivityDay',
      _i2m60d3i.ActivitySyncResult => 'ActivitySyncResult',
      _iwiby7qv.Arena => 'Arena',
      _ildu9ri2.ArenaRules => 'ArenaRules',
      _isxurcys.ArenaRun => 'ArenaRun',
      _ifo8s6zf.ArenaRunConfig => 'ArenaRunConfig',
      _i541vp0l.ArenaRunReport => 'ArenaRunReport',
      _ih8kl9mf.ArenaRunResult => 'ArenaRunResult',
      _ic5j8p21.ArenaRunStatus => 'ArenaRunStatus',
      _iz303hum.BattleMove => 'BattleMove',
      _ievndlqk.BattleStats => 'BattleStats',
      _in42pmv9.BiteBuddyException => 'BiteBuddyException',
      _i6546n9y.FeedResult => 'FeedResult',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _i4ouuzm2.Duel => 'Duel',
      _i9ikuwzg.DuelRound => 'DuelRound',
      _iwzwahda.DuelRoundView => 'DuelRoundView',
      _i1rc3le2.DuelStatus => 'DuelStatus',
      _ihf53btn.DuelView => 'DuelView',
      _iu6wab7g.League => 'League',
      _it8j4sh6.LeagueChallenge => 'LeagueChallenge',
      _i535uegq.LeagueDetail => 'LeagueDetail',
      _ixajhlyi.LeagueMember => 'LeagueMember',
      _itpdgapo.LeagueStanding => 'LeagueStanding',
      _idqobzdi.LeagueSummary => 'LeagueSummary',
      _i7znqzmr.SeasonResult => 'SeasonResult',
      _ij1ocmo2.Trophy => 'Trophy',
      _ixnoudrx.Meal => 'Meal',
      _igmlprfo.MealIdeas => 'MealIdeas',
      _iymppxeh.MealSuggestion => 'MealSuggestion',
      _ik434gbd.NutritionInsights => 'NutritionInsights',
      _i2ot5zrj.Opponent => 'Opponent',
      _ie9pyd3w.Pet => 'Pet',
      _it7bnlgl.PetSpecies => 'PetSpecies',
      _i1jr9gvy.PetPortrait => 'PetPortrait',
      _ijnz0svl.PortraitDraft => 'PortraitDraft',
      _igrz7ax7.StreakBuddy => 'StreakBuddy',
      _io8ln7w8.StreakBuddyStatus => 'StreakBuddyStatus',
      _i5rddhms.StreakBuddyView => 'StreakBuddyView',
      _ifaru43m.StreakFriend => 'StreakFriend',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('bite_buddy.', '');
    }

    switch (data) {
      case _igd8tknp.ActivityDay():
        return 'ActivityDay';
      case _i2m60d3i.ActivitySyncResult():
        return 'ActivitySyncResult';
      case _iwiby7qv.Arena():
        return 'Arena';
      case _ildu9ri2.ArenaRules():
        return 'ArenaRules';
      case _isxurcys.ArenaRun():
        return 'ArenaRun';
      case _ifo8s6zf.ArenaRunConfig():
        return 'ArenaRunConfig';
      case _i541vp0l.ArenaRunReport():
        return 'ArenaRunReport';
      case _ih8kl9mf.ArenaRunResult():
        return 'ArenaRunResult';
      case _ic5j8p21.ArenaRunStatus():
        return 'ArenaRunStatus';
      case _iz303hum.BattleMove():
        return 'BattleMove';
      case _ievndlqk.BattleStats():
        return 'BattleStats';
      case _in42pmv9.BiteBuddyException():
        return 'BiteBuddyException';
      case _i6546n9y.FeedResult():
        return 'FeedResult';
      case _ikawkn1p.LeaderboardEntry():
        return 'LeaderboardEntry';
      case _i4ouuzm2.Duel():
        return 'Duel';
      case _i9ikuwzg.DuelRound():
        return 'DuelRound';
      case _iwzwahda.DuelRoundView():
        return 'DuelRoundView';
      case _i1rc3le2.DuelStatus():
        return 'DuelStatus';
      case _ihf53btn.DuelView():
        return 'DuelView';
      case _iu6wab7g.League():
        return 'League';
      case _it8j4sh6.LeagueChallenge():
        return 'LeagueChallenge';
      case _i535uegq.LeagueDetail():
        return 'LeagueDetail';
      case _ixajhlyi.LeagueMember():
        return 'LeagueMember';
      case _itpdgapo.LeagueStanding():
        return 'LeagueStanding';
      case _idqobzdi.LeagueSummary():
        return 'LeagueSummary';
      case _i7znqzmr.SeasonResult():
        return 'SeasonResult';
      case _ij1ocmo2.Trophy():
        return 'Trophy';
      case _ixnoudrx.Meal():
        return 'Meal';
      case _igmlprfo.MealIdeas():
        return 'MealIdeas';
      case _iymppxeh.MealSuggestion():
        return 'MealSuggestion';
      case _ik434gbd.NutritionInsights():
        return 'NutritionInsights';
      case _i2ot5zrj.Opponent():
        return 'Opponent';
      case _ie9pyd3w.Pet():
        return 'Pet';
      case _it7bnlgl.PetSpecies():
        return 'PetSpecies';
      case _i1jr9gvy.PetPortrait():
        return 'PetPortrait';
      case _ijnz0svl.PortraitDraft():
        return 'PortraitDraft';
      case _igrz7ax7.StreakBuddy():
        return 'StreakBuddy';
      case _io8ln7w8.StreakBuddyStatus():
        return 'StreakBuddyStatus';
      case _i5rddhms.StreakBuddyView():
        return 'StreakBuddyView';
      case _ifaru43m.StreakFriend():
        return 'StreakFriend';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActivityDay') {
      return deserialize<_igd8tknp.ActivityDay>(data['data']);
    }
    if (dataClassName == 'ActivitySyncResult') {
      return deserialize<_i2m60d3i.ActivitySyncResult>(data['data']);
    }
    if (dataClassName == 'Arena') {
      return deserialize<_iwiby7qv.Arena>(data['data']);
    }
    if (dataClassName == 'ArenaRules') {
      return deserialize<_ildu9ri2.ArenaRules>(data['data']);
    }
    if (dataClassName == 'ArenaRun') {
      return deserialize<_isxurcys.ArenaRun>(data['data']);
    }
    if (dataClassName == 'ArenaRunConfig') {
      return deserialize<_ifo8s6zf.ArenaRunConfig>(data['data']);
    }
    if (dataClassName == 'ArenaRunReport') {
      return deserialize<_i541vp0l.ArenaRunReport>(data['data']);
    }
    if (dataClassName == 'ArenaRunResult') {
      return deserialize<_ih8kl9mf.ArenaRunResult>(data['data']);
    }
    if (dataClassName == 'ArenaRunStatus') {
      return deserialize<_ic5j8p21.ArenaRunStatus>(data['data']);
    }
    if (dataClassName == 'BattleMove') {
      return deserialize<_iz303hum.BattleMove>(data['data']);
    }
    if (dataClassName == 'BattleStats') {
      return deserialize<_ievndlqk.BattleStats>(data['data']);
    }
    if (dataClassName == 'BiteBuddyException') {
      return deserialize<_in42pmv9.BiteBuddyException>(data['data']);
    }
    if (dataClassName == 'FeedResult') {
      return deserialize<_i6546n9y.FeedResult>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ikawkn1p.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'Duel') {
      return deserialize<_i4ouuzm2.Duel>(data['data']);
    }
    if (dataClassName == 'DuelRound') {
      return deserialize<_i9ikuwzg.DuelRound>(data['data']);
    }
    if (dataClassName == 'DuelRoundView') {
      return deserialize<_iwzwahda.DuelRoundView>(data['data']);
    }
    if (dataClassName == 'DuelStatus') {
      return deserialize<_i1rc3le2.DuelStatus>(data['data']);
    }
    if (dataClassName == 'DuelView') {
      return deserialize<_ihf53btn.DuelView>(data['data']);
    }
    if (dataClassName == 'League') {
      return deserialize<_iu6wab7g.League>(data['data']);
    }
    if (dataClassName == 'LeagueChallenge') {
      return deserialize<_it8j4sh6.LeagueChallenge>(data['data']);
    }
    if (dataClassName == 'LeagueDetail') {
      return deserialize<_i535uegq.LeagueDetail>(data['data']);
    }
    if (dataClassName == 'LeagueMember') {
      return deserialize<_ixajhlyi.LeagueMember>(data['data']);
    }
    if (dataClassName == 'LeagueStanding') {
      return deserialize<_itpdgapo.LeagueStanding>(data['data']);
    }
    if (dataClassName == 'LeagueSummary') {
      return deserialize<_idqobzdi.LeagueSummary>(data['data']);
    }
    if (dataClassName == 'SeasonResult') {
      return deserialize<_i7znqzmr.SeasonResult>(data['data']);
    }
    if (dataClassName == 'Trophy') {
      return deserialize<_ij1ocmo2.Trophy>(data['data']);
    }
    if (dataClassName == 'Meal') {
      return deserialize<_ixnoudrx.Meal>(data['data']);
    }
    if (dataClassName == 'MealIdeas') {
      return deserialize<_igmlprfo.MealIdeas>(data['data']);
    }
    if (dataClassName == 'MealSuggestion') {
      return deserialize<_iymppxeh.MealSuggestion>(data['data']);
    }
    if (dataClassName == 'NutritionInsights') {
      return deserialize<_ik434gbd.NutritionInsights>(data['data']);
    }
    if (dataClassName == 'Opponent') {
      return deserialize<_i2ot5zrj.Opponent>(data['data']);
    }
    if (dataClassName == 'Pet') {
      return deserialize<_ie9pyd3w.Pet>(data['data']);
    }
    if (dataClassName == 'PetSpecies') {
      return deserialize<_it7bnlgl.PetSpecies>(data['data']);
    }
    if (dataClassName == 'PetPortrait') {
      return deserialize<_i1jr9gvy.PetPortrait>(data['data']);
    }
    if (dataClassName == 'PortraitDraft') {
      return deserialize<_ijnz0svl.PortraitDraft>(data['data']);
    }
    if (dataClassName == 'StreakBuddy') {
      return deserialize<_igrz7ax7.StreakBuddy>(data['data']);
    }
    if (dataClassName == 'StreakBuddyStatus') {
      return deserialize<_io8ln7w8.StreakBuddyStatus>(data['data']);
    }
    if (dataClassName == 'StreakBuddyView') {
      return deserialize<_i5rddhms.StreakBuddyView>(data['data']);
    }
    if (dataClassName == 'StreakFriend') {
      return deserialize<_ifaru43m.StreakFriend>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('bite_buddy', this);
    _iacs.Protocol().registerHostProtocol('bite_buddy', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _igd8tknp.ActivityDay:
        return _igd8tknp.ActivityDay.t;
      case _isxurcys.ArenaRun:
        return _isxurcys.ArenaRun.t;
      case _i4ouuzm2.Duel:
        return _i4ouuzm2.Duel.t;
      case _iu6wab7g.League:
        return _iu6wab7g.League.t;
      case _ixajhlyi.LeagueMember:
        return _ixajhlyi.LeagueMember.t;
      case _i7znqzmr.SeasonResult:
        return _i7znqzmr.SeasonResult.t;
      case _ij1ocmo2.Trophy:
        return _ij1ocmo2.Trophy.t;
      case _ixnoudrx.Meal:
        return _ixnoudrx.Meal.t;
      case _igmlprfo.MealIdeas:
        return _igmlprfo.MealIdeas.t;
      case _ie9pyd3w.Pet:
        return _ie9pyd3w.Pet.t;
      case _i1jr9gvy.PetPortrait:
        return _i1jr9gvy.PetPortrait.t;
      case _igrz7ax7.StreakBuddy:
        return _igrz7ax7.StreakBuddy.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'bite_buddy';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

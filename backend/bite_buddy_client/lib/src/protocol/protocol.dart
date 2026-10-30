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
import 'package:bite_buddy_client/src/protocol/leaderboard_entry.dart'
    as _iw02fr1r;
import 'package:bite_buddy_client/src/protocol/league/league_summary.dart'
    as _i4dmvkfy;
import 'package:bite_buddy_client/src/protocol/league/trophy.dart' as _iaaiiecv;
import 'package:bite_buddy_client/src/protocol/meal.dart' as _is4r12e0;
import 'package:bite_buddy_client/src/protocol/pet_species.dart' as _i12uia3s;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'arena.dart' as _iwiby7qv;
import 'battle.dart' as _inh3lnzs;
import 'battle_move.dart' as _iz303hum;
import 'battle_round.dart' as _imrf8vtu;
import 'battle_state.dart' as _iavxxxi0;
import 'battle_stats.dart' as _ievndlqk;
import 'battle_status.dart' as _ib4xlijd;
import 'errors/bite_buddy_exception.dart' as _in42pmv9;
import 'feed_result.dart' as _i6546n9y;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'league/duel.dart' as _i4ouuzm2;
import 'league/duel_round.dart' as _i9ikuwzg;
import 'league/duel_round_view.dart' as _iwzwahda;
import 'league/duel_status.dart' as _i1rc3le2;
import 'league/duel_view.dart' as _ihf53btn;
import 'league/league.dart' as _iu6wab7g;
import 'league/league_detail.dart' as _i535uegq;
import 'league/league_member.dart' as _ixajhlyi;
import 'league/league_standing.dart' as _itpdgapo;
import 'league/league_summary.dart' as _idqobzdi;
import 'league/season_result.dart' as _i7znqzmr;
import 'league/trophy.dart' as _ij1ocmo2;
import 'meal.dart' as _ixnoudrx;
import 'nutrition_insights.dart' as _ik434gbd;
import 'opponent.dart' as _i2ot5zrj;
import 'pet.dart' as _ie9pyd3w;
import 'pet_species.dart' as _it7bnlgl;
export 'arena.dart';
export 'battle.dart';
export 'battle_move.dart';
export 'battle_round.dart';
export 'battle_state.dart';
export 'battle_stats.dart';
export 'battle_status.dart';
export 'errors/bite_buddy_exception.dart';
export 'feed_result.dart';
export 'leaderboard_entry.dart';
export 'league/duel.dart';
export 'league/duel_round.dart';
export 'league/duel_round_view.dart';
export 'league/duel_status.dart';
export 'league/duel_view.dart';
export 'league/league.dart';
export 'league/league_detail.dart';
export 'league/league_member.dart';
export 'league/league_standing.dart';
export 'league/league_summary.dart';
export 'league/season_result.dart';
export 'league/trophy.dart';
export 'meal.dart';
export 'nutrition_insights.dart';
export 'opponent.dart';
export 'pet.dart';
export 'pet_species.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iwiby7qv.Arena) {
      return _iwiby7qv.Arena.fromJson(data) as T;
    }
    if (t == _inh3lnzs.Battle) {
      return _inh3lnzs.Battle.fromJson(data) as T;
    }
    if (t == _iz303hum.BattleMove) {
      return _iz303hum.BattleMove.fromJson(data) as T;
    }
    if (t == _imrf8vtu.BattleRound) {
      return _imrf8vtu.BattleRound.fromJson(data) as T;
    }
    if (t == _iavxxxi0.BattleState) {
      return _iavxxxi0.BattleState.fromJson(data) as T;
    }
    if (t == _ievndlqk.BattleStats) {
      return _ievndlqk.BattleStats.fromJson(data) as T;
    }
    if (t == _ib4xlijd.BattleStatus) {
      return _ib4xlijd.BattleStatus.fromJson(data) as T;
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
    if (t == _isc.getType<_iwiby7qv.Arena?>()) {
      return (data != null ? _iwiby7qv.Arena.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inh3lnzs.Battle?>()) {
      return (data != null ? _inh3lnzs.Battle.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iz303hum.BattleMove?>()) {
      return (data != null ? _iz303hum.BattleMove.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imrf8vtu.BattleRound?>()) {
      return (data != null ? _imrf8vtu.BattleRound.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iavxxxi0.BattleState?>()) {
      return (data != null ? _iavxxxi0.BattleState.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ievndlqk.BattleStats?>()) {
      return (data != null ? _ievndlqk.BattleStats.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ib4xlijd.BattleStatus?>()) {
      return (data != null ? _ib4xlijd.BattleStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_in42pmv9.BiteBuddyException?>()) {
      return (data != null ? _in42pmv9.BiteBuddyException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6546n9y.FeedResult?>()) {
      return (data != null ? _i6546n9y.FeedResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4ouuzm2.Duel?>()) {
      return (data != null ? _i4ouuzm2.Duel.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9ikuwzg.DuelRound?>()) {
      return (data != null ? _i9ikuwzg.DuelRound.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwzwahda.DuelRoundView?>()) {
      return (data != null ? _iwzwahda.DuelRoundView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1rc3le2.DuelStatus?>()) {
      return (data != null ? _i1rc3le2.DuelStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihf53btn.DuelView?>()) {
      return (data != null ? _ihf53btn.DuelView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu6wab7g.League?>()) {
      return (data != null ? _iu6wab7g.League.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i535uegq.LeagueDetail?>()) {
      return (data != null ? _i535uegq.LeagueDetail.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixajhlyi.LeagueMember?>()) {
      return (data != null ? _ixajhlyi.LeagueMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itpdgapo.LeagueStanding?>()) {
      return (data != null ? _itpdgapo.LeagueStanding.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idqobzdi.LeagueSummary?>()) {
      return (data != null ? _idqobzdi.LeagueSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7znqzmr.SeasonResult?>()) {
      return (data != null ? _i7znqzmr.SeasonResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ij1ocmo2.Trophy?>()) {
      return (data != null ? _ij1ocmo2.Trophy.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixnoudrx.Meal?>()) {
      return (data != null ? _ixnoudrx.Meal.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik434gbd.NutritionInsights?>()) {
      return (data != null ? _ik434gbd.NutritionInsights.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2ot5zrj.Opponent?>()) {
      return (data != null ? _i2ot5zrj.Opponent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ie9pyd3w.Pet?>()) {
      return (data != null ? _ie9pyd3w.Pet.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it7bnlgl.PetSpecies?>()) {
      return (data != null ? _it7bnlgl.PetSpecies.fromJson(data) : null) as T;
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
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iw02fr1r.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_iw02fr1r.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i4dmvkfy.LeagueSummary>) {
      return (data as List)
              .map((e) => deserialize<_i4dmvkfy.LeagueSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_iaaiiecv.Trophy>) {
      return (data as List)
              .map((e) => deserialize<_iaaiiecv.Trophy>(e))
              .toList()
          as T;
    }
    if (t == List<_is4r12e0.Meal>) {
      return (data as List).map((e) => deserialize<_is4r12e0.Meal>(e)).toList()
          as T;
    }
    if (t == List<_i12uia3s.PetSpecies>) {
      return (data as List)
              .map((e) => deserialize<_i12uia3s.PetSpecies>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iwiby7qv.Arena => 'Arena',
      _inh3lnzs.Battle => 'Battle',
      _iz303hum.BattleMove => 'BattleMove',
      _imrf8vtu.BattleRound => 'BattleRound',
      _iavxxxi0.BattleState => 'BattleState',
      _ievndlqk.BattleStats => 'BattleStats',
      _ib4xlijd.BattleStatus => 'BattleStatus',
      _in42pmv9.BiteBuddyException => 'BiteBuddyException',
      _i6546n9y.FeedResult => 'FeedResult',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _i4ouuzm2.Duel => 'Duel',
      _i9ikuwzg.DuelRound => 'DuelRound',
      _iwzwahda.DuelRoundView => 'DuelRoundView',
      _i1rc3le2.DuelStatus => 'DuelStatus',
      _ihf53btn.DuelView => 'DuelView',
      _iu6wab7g.League => 'League',
      _i535uegq.LeagueDetail => 'LeagueDetail',
      _ixajhlyi.LeagueMember => 'LeagueMember',
      _itpdgapo.LeagueStanding => 'LeagueStanding',
      _idqobzdi.LeagueSummary => 'LeagueSummary',
      _i7znqzmr.SeasonResult => 'SeasonResult',
      _ij1ocmo2.Trophy => 'Trophy',
      _ixnoudrx.Meal => 'Meal',
      _ik434gbd.NutritionInsights => 'NutritionInsights',
      _i2ot5zrj.Opponent => 'Opponent',
      _ie9pyd3w.Pet => 'Pet',
      _it7bnlgl.PetSpecies => 'PetSpecies',
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
      case _iwiby7qv.Arena():
        return 'Arena';
      case _inh3lnzs.Battle():
        return 'Battle';
      case _iz303hum.BattleMove():
        return 'BattleMove';
      case _imrf8vtu.BattleRound():
        return 'BattleRound';
      case _iavxxxi0.BattleState():
        return 'BattleState';
      case _ievndlqk.BattleStats():
        return 'BattleStats';
      case _ib4xlijd.BattleStatus():
        return 'BattleStatus';
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
      case _ik434gbd.NutritionInsights():
        return 'NutritionInsights';
      case _i2ot5zrj.Opponent():
        return 'Opponent';
      case _ie9pyd3w.Pet():
        return 'Pet';
      case _it7bnlgl.PetSpecies():
        return 'PetSpecies';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Arena') {
      return deserialize<_iwiby7qv.Arena>(data['data']);
    }
    if (dataClassName == 'Battle') {
      return deserialize<_inh3lnzs.Battle>(data['data']);
    }
    if (dataClassName == 'BattleMove') {
      return deserialize<_iz303hum.BattleMove>(data['data']);
    }
    if (dataClassName == 'BattleRound') {
      return deserialize<_imrf8vtu.BattleRound>(data['data']);
    }
    if (dataClassName == 'BattleState') {
      return deserialize<_iavxxxi0.BattleState>(data['data']);
    }
    if (dataClassName == 'BattleStats') {
      return deserialize<_ievndlqk.BattleStats>(data['data']);
    }
    if (dataClassName == 'BattleStatus') {
      return deserialize<_ib4xlijd.BattleStatus>(data['data']);
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
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('bite_buddy', this);
    _iacc.Protocol().registerHostProtocol('bite_buddy', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}

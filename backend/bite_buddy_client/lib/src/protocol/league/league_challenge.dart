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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// This week's team goal for a league. Everyone works on it together; when
/// it's met by the end of the season, every member gets [rewardCoins].
abstract class LeagueChallenge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LeagueChallenge._({
    required this.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.completed,
    required this.rewardCoins,
  });

  factory LeagueChallenge({
    required String key,
    required String title,
    required String description,
    required int progress,
    required int target,
    required bool completed,
    required int rewardCoins,
  }) = _LeagueChallengeImpl;

  factory LeagueChallenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeagueChallenge(
      key: jsonSerialization['key'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      progress: jsonSerialization['progress'] as int,
      target: jsonSerialization['target'] as int,
      completed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['completed'],
      ),
      rewardCoins: jsonSerialization['rewardCoins'] as int,
    );
  }

  String key;

  String title;

  String description;

  int progress;

  int target;

  bool completed;

  int rewardCoins;

  /// Returns a shallow copy of this [LeagueChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LeagueChallenge copyWith({
    String? key,
    String? title,
    String? description,
    int? progress,
    int? target,
    bool? completed,
    int? rewardCoins,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueChallenge',
      'key': key,
      'title': title,
      'description': description,
      'progress': progress,
      'target': target,
      'completed': completed,
      'rewardCoins': rewardCoins,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueChallenge',
      'key': key,
      'title': title,
      'description': description,
      'progress': progress,
      'target': target,
      'completed': completed,
      'rewardCoins': rewardCoins,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LeagueChallengeImpl extends LeagueChallenge {
  _LeagueChallengeImpl({
    required String key,
    required String title,
    required String description,
    required int progress,
    required int target,
    required bool completed,
    required int rewardCoins,
  }) : super._(
         key: key,
         title: title,
         description: description,
         progress: progress,
         target: target,
         completed: completed,
         rewardCoins: rewardCoins,
       );

  /// Returns a shallow copy of this [LeagueChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LeagueChallenge copyWith({
    String? key,
    String? title,
    String? description,
    int? progress,
    int? target,
    bool? completed,
    int? rewardCoins,
  }) {
    return LeagueChallenge(
      key: key ?? this.key,
      title: title ?? this.title,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      completed: completed ?? this.completed,
      rewardCoins: rewardCoins ?? this.rewardCoins,
    );
  }
}

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

/// A shared streak between two league friends, Duolingo style: a day only
/// counts when both of them feed their buddy. [aUserId] sent the invite.
abstract class StreakBuddy
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StreakBuddy._({
    this.id,
    required this.aUserId,
    required this.bUserId,
    required this.accepted,
    required this.streak,
    required this.bestStreak,
    this.aLastFedDay,
    this.bLastFedDay,
    this.lastStreakDay,
    required this.createdAt,
  });

  factory StreakBuddy({
    int? id,
    required _isc.UuidValue aUserId,
    required _isc.UuidValue bUserId,
    required bool accepted,
    required int streak,
    required int bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    required DateTime createdAt,
  }) = _StreakBuddyImpl;

  factory StreakBuddy.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreakBuddy(
      id: jsonSerialization['id'] as int?,
      aUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['aUserId'],
      ),
      bUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['bUserId'],
      ),
      accepted: _isc.BoolJsonExtension.fromJson(jsonSerialization['accepted']),
      streak: jsonSerialization['streak'] as int,
      bestStreak: jsonSerialization['bestStreak'] as int,
      aLastFedDay: jsonSerialization['aLastFedDay'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['aLastFedDay'],
            ),
      bLastFedDay: jsonSerialization['bLastFedDay'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['bLastFedDay'],
            ),
      lastStreakDay: jsonSerialization['lastStreakDay'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStreakDay'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue aUserId;

  _isc.UuidValue bUserId;

  /// False until [bUserId] accepts the invite.
  bool accepted;

  /// Days in a row both friends fed. Missing a whole day resets it to 0.
  int streak;

  int bestStreak;

  /// The last local day (UTC midnight) each friend fed while paired.
  DateTime? aLastFedDay;

  DateTime? bLastFedDay;

  /// The last day that counted for the shared streak.
  DateTime? lastStreakDay;

  DateTime createdAt;

  /// Returns a shallow copy of this [StreakBuddy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StreakBuddy copyWith({
    int? id,
    _isc.UuidValue? aUserId,
    _isc.UuidValue? bUserId,
    bool? accepted,
    int? streak,
    int? bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreakBuddy',
      if (id != null) 'id': id,
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'accepted': accepted,
      'streak': streak,
      'bestStreak': bestStreak,
      if (aLastFedDay != null) 'aLastFedDay': aLastFedDay?.toJson(),
      if (bLastFedDay != null) 'bLastFedDay': bLastFedDay?.toJson(),
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreakBuddy',
      if (id != null) 'id': id,
      'aUserId': aUserId.toJson(),
      'bUserId': bUserId.toJson(),
      'accepted': accepted,
      'streak': streak,
      'bestStreak': bestStreak,
      if (aLastFedDay != null) 'aLastFedDay': aLastFedDay?.toJson(),
      if (bLastFedDay != null) 'bLastFedDay': bLastFedDay?.toJson(),
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreakBuddyImpl extends StreakBuddy {
  _StreakBuddyImpl({
    int? id,
    required _isc.UuidValue aUserId,
    required _isc.UuidValue bUserId,
    required bool accepted,
    required int streak,
    required int bestStreak,
    DateTime? aLastFedDay,
    DateTime? bLastFedDay,
    DateTime? lastStreakDay,
    required DateTime createdAt,
  }) : super._(
         id: id,
         aUserId: aUserId,
         bUserId: bUserId,
         accepted: accepted,
         streak: streak,
         bestStreak: bestStreak,
         aLastFedDay: aLastFedDay,
         bLastFedDay: bLastFedDay,
         lastStreakDay: lastStreakDay,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StreakBuddy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StreakBuddy copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? aUserId,
    _isc.UuidValue? bUserId,
    bool? accepted,
    int? streak,
    int? bestStreak,
    Object? aLastFedDay = _Undefined,
    Object? bLastFedDay = _Undefined,
    Object? lastStreakDay = _Undefined,
    DateTime? createdAt,
  }) {
    return StreakBuddy(
      id: id is int? ? id : this.id,
      aUserId: aUserId ?? this.aUserId,
      bUserId: bUserId ?? this.bUserId,
      accepted: accepted ?? this.accepted,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      aLastFedDay: aLastFedDay is DateTime? ? aLastFedDay : this.aLastFedDay,
      bLastFedDay: bLastFedDay is DateTime? ? bLastFedDay : this.bLastFedDay,
      lastStreakDay: lastStreakDay is DateTime?
          ? lastStreakDay
          : this.lastStreakDay,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

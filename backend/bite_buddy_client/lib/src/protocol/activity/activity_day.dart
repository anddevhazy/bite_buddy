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

/// Steps and sleep from Apple Health or Health Connect for one local day,
/// and how much they've already boosted the pet, so a day pays out once.
abstract class ActivityDay
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ActivityDay._({
    this.id,
    required this.ownerId,
    required this.day,
    required this.steps,
    required this.sleepMinutes,
    required this.energyAwarded,
    required this.healthAwarded,
    required this.updatedAt,
  });

  factory ActivityDay({
    int? id,
    required _isc.UuidValue ownerId,
    required DateTime day,
    required int steps,
    required int sleepMinutes,
    required int energyAwarded,
    required int healthAwarded,
    required DateTime updatedAt,
  }) = _ActivityDayImpl;

  factory ActivityDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityDay(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      day: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      steps: jsonSerialization['steps'] as int,
      sleepMinutes: jsonSerialization['sleepMinutes'] as int,
      energyAwarded: jsonSerialization['energyAwarded'] as int,
      healthAwarded: jsonSerialization['healthAwarded'] as int,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue ownerId;

  /// The owner's local day (UTC midnight).
  DateTime day;

  int steps;

  /// Sleep in the night that ended this morning.
  int sleepMinutes;

  int energyAwarded;

  int healthAwarded;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ActivityDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ActivityDay copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    DateTime? day,
    int? steps,
    int? sleepMinutes,
    int? energyAwarded,
    int? healthAwarded,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityDay',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyAwarded': energyAwarded,
      'healthAwarded': healthAwarded,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityDay',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyAwarded': energyAwarded,
      'healthAwarded': healthAwarded,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityDayImpl extends ActivityDay {
  _ActivityDayImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required DateTime day,
    required int steps,
    required int sleepMinutes,
    required int energyAwarded,
    required int healthAwarded,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         day: day,
         steps: steps,
         sleepMinutes: sleepMinutes,
         energyAwarded: energyAwarded,
         healthAwarded: healthAwarded,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ActivityDay]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ActivityDay copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    DateTime? day,
    int? steps,
    int? sleepMinutes,
    int? energyAwarded,
    int? healthAwarded,
    DateTime? updatedAt,
  }) {
    return ActivityDay(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      day: day ?? this.day,
      steps: steps ?? this.steps,
      sleepMinutes: sleepMinutes ?? this.sleepMinutes,
      energyAwarded: energyAwarded ?? this.energyAwarded,
      healthAwarded: healthAwarded ?? this.healthAwarded,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

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
import 'package:bite_buddy_server/src/generated/protocol.dart' as _i61ow1lb;
import 'package:serverpod/serverpod.dart' as _is;
import '../pet.dart' as _irsmjef4;

/// The pet after a health sync, and what today's activity has earned.
abstract class ActivitySyncResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ActivitySyncResult._({
    required this.pet,
    required this.steps,
    required this.sleepMinutes,
    required this.energyGained,
    required this.healthGained,
    required this.energyToday,
    required this.healthToday,
    required this.maxEnergyPerDay,
    required this.maxHealthPerDay,
  });

  factory ActivitySyncResult({
    required _irsmjef4.Pet pet,
    required int steps,
    required int sleepMinutes,
    required int energyGained,
    required int healthGained,
    required int energyToday,
    required int healthToday,
    required int maxEnergyPerDay,
    required int maxHealthPerDay,
  }) = _ActivitySyncResultImpl;

  factory ActivitySyncResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivitySyncResult(
      pet: _i61ow1lb.Protocol().deserialize<_irsmjef4.Pet>(
        jsonSerialization['pet'],
      ),
      steps: jsonSerialization['steps'] as int,
      sleepMinutes: jsonSerialization['sleepMinutes'] as int,
      energyGained: jsonSerialization['energyGained'] as int,
      healthGained: jsonSerialization['healthGained'] as int,
      energyToday: jsonSerialization['energyToday'] as int,
      healthToday: jsonSerialization['healthToday'] as int,
      maxEnergyPerDay: jsonSerialization['maxEnergyPerDay'] as int,
      maxHealthPerDay: jsonSerialization['maxHealthPerDay'] as int,
    );
  }

  _irsmjef4.Pet pet;

  int steps;

  int sleepMinutes;

  /// Gained from this sync only.
  int energyGained;

  int healthGained;

  /// Today's totals so far, out of the daily caps.
  int energyToday;

  int healthToday;

  int maxEnergyPerDay;

  int maxHealthPerDay;

  /// Returns a shallow copy of this [ActivitySyncResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ActivitySyncResult copyWith({
    _irsmjef4.Pet? pet,
    int? steps,
    int? sleepMinutes,
    int? energyGained,
    int? healthGained,
    int? energyToday,
    int? healthToday,
    int? maxEnergyPerDay,
    int? maxHealthPerDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivitySyncResult',
      'pet': pet.toJson(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyGained': energyGained,
      'healthGained': healthGained,
      'energyToday': energyToday,
      'healthToday': healthToday,
      'maxEnergyPerDay': maxEnergyPerDay,
      'maxHealthPerDay': maxHealthPerDay,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivitySyncResult',
      'pet': pet.toJsonForProtocol(),
      'steps': steps,
      'sleepMinutes': sleepMinutes,
      'energyGained': energyGained,
      'healthGained': healthGained,
      'energyToday': energyToday,
      'healthToday': healthToday,
      'maxEnergyPerDay': maxEnergyPerDay,
      'maxHealthPerDay': maxHealthPerDay,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ActivitySyncResultImpl extends ActivitySyncResult {
  _ActivitySyncResultImpl({
    required _irsmjef4.Pet pet,
    required int steps,
    required int sleepMinutes,
    required int energyGained,
    required int healthGained,
    required int energyToday,
    required int healthToday,
    required int maxEnergyPerDay,
    required int maxHealthPerDay,
  }) : super._(
         pet: pet,
         steps: steps,
         sleepMinutes: sleepMinutes,
         energyGained: energyGained,
         healthGained: healthGained,
         energyToday: energyToday,
         healthToday: healthToday,
         maxEnergyPerDay: maxEnergyPerDay,
         maxHealthPerDay: maxHealthPerDay,
       );

  /// Returns a shallow copy of this [ActivitySyncResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ActivitySyncResult copyWith({
    _irsmjef4.Pet? pet,
    int? steps,
    int? sleepMinutes,
    int? energyGained,
    int? healthGained,
    int? energyToday,
    int? healthToday,
    int? maxEnergyPerDay,
    int? maxHealthPerDay,
  }) {
    return ActivitySyncResult(
      pet: pet ?? this.pet.copyWith(),
      steps: steps ?? this.steps,
      sleepMinutes: sleepMinutes ?? this.sleepMinutes,
      energyGained: energyGained ?? this.energyGained,
      healthGained: healthGained ?? this.healthGained,
      energyToday: energyToday ?? this.energyToday,
      healthToday: healthToday ?? this.healthToday,
      maxEnergyPerDay: maxEnergyPerDay ?? this.maxEnergyPerDay,
      maxHealthPerDay: maxHealthPerDay ?? this.maxHealthPerDay,
    );
  }
}

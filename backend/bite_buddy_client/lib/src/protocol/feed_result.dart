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
import 'package:bite_buddy_client/src/protocol/protocol.dart' as _i7z1njky;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'pet.dart' as _ie9pyd3w;

/// The pet after a meal, and how much each stat moved.
abstract class FeedResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedResult._({
    required this.pet,
    required this.healthChange,
    required this.energyChange,
    required this.nutritionChange,
    required this.xpGained,
    required this.leveledUp,
    required this.streakExtended,
    required this.streakBonusXp,
    required this.fullHealthBonusXp,
    int? sharedStreaksGrown,
  }) : sharedStreaksGrown = sharedStreaksGrown ?? 0;

  factory FeedResult({
    required _ie9pyd3w.Pet pet,
    required int healthChange,
    required int energyChange,
    required int nutritionChange,
    required int xpGained,
    required bool leveledUp,
    required bool streakExtended,
    required int streakBonusXp,
    required int fullHealthBonusXp,
    int? sharedStreaksGrown,
  }) = _FeedResultImpl;

  factory FeedResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedResult(
      pet: _i7z1njky.Protocol().deserialize<_ie9pyd3w.Pet>(
        jsonSerialization['pet'],
      ),
      healthChange: jsonSerialization['healthChange'] as int,
      energyChange: jsonSerialization['energyChange'] as int,
      nutritionChange: jsonSerialization['nutritionChange'] as int,
      xpGained: jsonSerialization['xpGained'] as int,
      leveledUp: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['leveledUp'],
      ),
      streakExtended: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['streakExtended'],
      ),
      streakBonusXp: jsonSerialization['streakBonusXp'] as int,
      fullHealthBonusXp: jsonSerialization['fullHealthBonusXp'] as int,
      sharedStreaksGrown: jsonSerialization['sharedStreaksGrown'] as int?,
    );
  }

  _ie9pyd3w.Pet pet;

  int healthChange;

  int energyChange;

  int nutritionChange;

  int xpGained;

  bool leveledUp;

  /// True when this was the first meal of a new streak day.
  bool streakExtended;

  /// Bonus XP for the streak, already included in xpGained.
  int streakBonusXp;

  /// Healing past 100 health, turned into XP so a good meal is never wasted
  /// at full health. Already included in xpGained.
  int fullHealthBonusXp;

  /// Shared streaks with friends that grew with this meal. Each one also
  /// paid both friends a few coins, already included in pet.coins.
  int sharedStreaksGrown;

  /// Returns a shallow copy of this [FeedResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedResult copyWith({
    _ie9pyd3w.Pet? pet,
    int? healthChange,
    int? energyChange,
    int? nutritionChange,
    int? xpGained,
    bool? leveledUp,
    bool? streakExtended,
    int? streakBonusXp,
    int? fullHealthBonusXp,
    int? sharedStreaksGrown,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedResult',
      'pet': pet.toJson(),
      'healthChange': healthChange,
      'energyChange': energyChange,
      'nutritionChange': nutritionChange,
      'xpGained': xpGained,
      'leveledUp': leveledUp,
      'streakExtended': streakExtended,
      'streakBonusXp': streakBonusXp,
      'fullHealthBonusXp': fullHealthBonusXp,
      'sharedStreaksGrown': sharedStreaksGrown,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedResult',
      'pet': pet.toJsonForProtocol(),
      'healthChange': healthChange,
      'energyChange': energyChange,
      'nutritionChange': nutritionChange,
      'xpGained': xpGained,
      'leveledUp': leveledUp,
      'streakExtended': streakExtended,
      'streakBonusXp': streakBonusXp,
      'fullHealthBonusXp': fullHealthBonusXp,
      'sharedStreaksGrown': sharedStreaksGrown,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FeedResultImpl extends FeedResult {
  _FeedResultImpl({
    required _ie9pyd3w.Pet pet,
    required int healthChange,
    required int energyChange,
    required int nutritionChange,
    required int xpGained,
    required bool leveledUp,
    required bool streakExtended,
    required int streakBonusXp,
    required int fullHealthBonusXp,
    int? sharedStreaksGrown,
  }) : super._(
         pet: pet,
         healthChange: healthChange,
         energyChange: energyChange,
         nutritionChange: nutritionChange,
         xpGained: xpGained,
         leveledUp: leveledUp,
         streakExtended: streakExtended,
         streakBonusXp: streakBonusXp,
         fullHealthBonusXp: fullHealthBonusXp,
         sharedStreaksGrown: sharedStreaksGrown,
       );

  /// Returns a shallow copy of this [FeedResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedResult copyWith({
    _ie9pyd3w.Pet? pet,
    int? healthChange,
    int? energyChange,
    int? nutritionChange,
    int? xpGained,
    bool? leveledUp,
    bool? streakExtended,
    int? streakBonusXp,
    int? fullHealthBonusXp,
    int? sharedStreaksGrown,
  }) {
    return FeedResult(
      pet: pet ?? this.pet.copyWith(),
      healthChange: healthChange ?? this.healthChange,
      energyChange: energyChange ?? this.energyChange,
      nutritionChange: nutritionChange ?? this.nutritionChange,
      xpGained: xpGained ?? this.xpGained,
      leveledUp: leveledUp ?? this.leveledUp,
      streakExtended: streakExtended ?? this.streakExtended,
      streakBonusXp: streakBonusXp ?? this.streakBonusXp,
      fullHealthBonusXp: fullHealthBonusXp ?? this.fullHealthBonusXp,
      sharedStreaksGrown: sharedStreaksGrown ?? this.sharedStreaksGrown,
    );
  }
}

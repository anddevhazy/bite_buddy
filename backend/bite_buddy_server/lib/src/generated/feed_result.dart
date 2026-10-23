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
import 'pet.dart' as _ie9pyd3w;

/// The pet after a meal, and how much each stat moved.
abstract class FeedResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeedResult._({
    required this.pet,
    required this.healthChange,
    required this.energyChange,
    required this.nutritionChange,
    required this.xpGained,
    required this.leveledUp,
  });

  factory FeedResult({
    required _ie9pyd3w.Pet pet,
    required int healthChange,
    required int energyChange,
    required int nutritionChange,
    required int xpGained,
    required bool leveledUp,
  }) = _FeedResultImpl;

  factory FeedResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedResult(
      pet: _i61ow1lb.Protocol().deserialize<_ie9pyd3w.Pet>(
        jsonSerialization['pet'],
      ),
      healthChange: jsonSerialization['healthChange'] as int,
      energyChange: jsonSerialization['energyChange'] as int,
      nutritionChange: jsonSerialization['nutritionChange'] as int,
      xpGained: jsonSerialization['xpGained'] as int,
      leveledUp: _is.BoolJsonExtension.fromJson(jsonSerialization['leveledUp']),
    );
  }

  _ie9pyd3w.Pet pet;

  int healthChange;

  int energyChange;

  int nutritionChange;

  int xpGained;

  bool leveledUp;

  /// Returns a shallow copy of this [FeedResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedResult copyWith({
    _ie9pyd3w.Pet? pet,
    int? healthChange,
    int? energyChange,
    int? nutritionChange,
    int? xpGained,
    bool? leveledUp,
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
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  }) : super._(
         pet: pet,
         healthChange: healthChange,
         energyChange: energyChange,
         nutritionChange: nutritionChange,
         xpGained: xpGained,
         leveledUp: leveledUp,
       );

  /// Returns a shallow copy of this [FeedResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedResult copyWith({
    _ie9pyd3w.Pet? pet,
    int? healthChange,
    int? energyChange,
    int? nutritionChange,
    int? xpGained,
    bool? leveledUp,
  }) {
    return FeedResult(
      pet: pet ?? this.pet.copyWith(),
      healthChange: healthChange ?? this.healthChange,
      energyChange: energyChange ?? this.energyChange,
      nutritionChange: nutritionChange ?? this.nutritionChange,
      xpGained: xpGained ?? this.xpGained,
      leveledUp: leveledUp ?? this.leveledUp,
    );
  }
}

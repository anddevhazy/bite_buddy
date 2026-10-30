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
import 'package:serverpod/serverpod.dart' as _is;

/// Average share of the daily target per day with meals, in percent.
abstract class NutrientBalance
    implements _is.SerializableModel, _is.ProtocolSerialization {
  NutrientBalance._({
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.vitamins,
    required this.minerals,
    required this.fiber,
  });

  factory NutrientBalance({
    required int protein,
    required int carbs,
    required int fats,
    required int vitamins,
    required int minerals,
    required int fiber,
  }) = _NutrientBalanceImpl;

  factory NutrientBalance.fromJson(Map<String, dynamic> jsonSerialization) {
    return NutrientBalance(
      protein: jsonSerialization['protein'] as int,
      carbs: jsonSerialization['carbs'] as int,
      fats: jsonSerialization['fats'] as int,
      vitamins: jsonSerialization['vitamins'] as int,
      minerals: jsonSerialization['minerals'] as int,
      fiber: jsonSerialization['fiber'] as int,
    );
  }

  int protein;

  int carbs;

  int fats;

  int vitamins;

  int minerals;

  int fiber;

  /// Returns a shallow copy of this [NutrientBalance]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NutrientBalance copyWith({
    int? protein,
    int? carbs,
    int? fats,
    int? vitamins,
    int? minerals,
    int? fiber,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NutrientBalance',
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'vitamins': vitamins,
      'minerals': minerals,
      'fiber': fiber,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NutrientBalance',
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'vitamins': vitamins,
      'minerals': minerals,
      'fiber': fiber,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _NutrientBalanceImpl extends NutrientBalance {
  _NutrientBalanceImpl({
    required int protein,
    required int carbs,
    required int fats,
    required int vitamins,
    required int minerals,
    required int fiber,
  }) : super._(
         protein: protein,
         carbs: carbs,
         fats: fats,
         vitamins: vitamins,
         minerals: minerals,
         fiber: fiber,
       );

  /// Returns a shallow copy of this [NutrientBalance]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NutrientBalance copyWith({
    int? protein,
    int? carbs,
    int? fats,
    int? vitamins,
    int? minerals,
    int? fiber,
  }) {
    return NutrientBalance(
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      vitamins: vitamins ?? this.vitamins,
      minerals: minerals ?? this.minerals,
      fiber: fiber ?? this.fiber,
    );
  }
}

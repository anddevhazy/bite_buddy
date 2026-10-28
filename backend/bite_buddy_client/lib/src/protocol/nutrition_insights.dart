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

/// A summary of the meals the pet ate over the last 7 days, with tips.
abstract class NutritionInsights
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NutritionInsights._({
    required this.mealsCounted,
    required this.daysWithMeals,
    required this.averageHealthScore,
    required this.proteinPct,
    required this.carbsPct,
    required this.fatsPct,
    required this.vitaminsPct,
    required this.mineralsPct,
    required this.fiberPct,
    this.bestMealName,
    required this.tips,
  });

  factory NutritionInsights({
    required int mealsCounted,
    required int daysWithMeals,
    required int averageHealthScore,
    required int proteinPct,
    required int carbsPct,
    required int fatsPct,
    required int vitaminsPct,
    required int mineralsPct,
    required int fiberPct,
    String? bestMealName,
    required List<String> tips,
  }) = _NutritionInsightsImpl;

  factory NutritionInsights.fromJson(Map<String, dynamic> jsonSerialization) {
    return NutritionInsights(
      mealsCounted: jsonSerialization['mealsCounted'] as int,
      daysWithMeals: jsonSerialization['daysWithMeals'] as int,
      averageHealthScore: jsonSerialization['averageHealthScore'] as int,
      proteinPct: jsonSerialization['proteinPct'] as int,
      carbsPct: jsonSerialization['carbsPct'] as int,
      fatsPct: jsonSerialization['fatsPct'] as int,
      vitaminsPct: jsonSerialization['vitaminsPct'] as int,
      mineralsPct: jsonSerialization['mineralsPct'] as int,
      fiberPct: jsonSerialization['fiberPct'] as int,
      bestMealName: jsonSerialization['bestMealName'] as String?,
      tips: _i7z1njky.Protocol().deserialize<List<String>>(
        jsonSerialization['tips'],
      ),
    );
  }

  int mealsCounted;

  /// Days in the last 7 with at least one meal.
  int daysWithMeals;

  /// 0-100, or 0 when there are no meals.
  int averageHealthScore;

  /// Average per day with meals, as a percent of the daily target.
  int proteinPct;

  int carbsPct;

  int fatsPct;

  int vitaminsPct;

  int mineralsPct;

  int fiberPct;

  String? bestMealName;

  /// Up to 3 short suggestions, most important first.
  List<String> tips;

  /// Returns a shallow copy of this [NutritionInsights]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NutritionInsights copyWith({
    int? mealsCounted,
    int? daysWithMeals,
    int? averageHealthScore,
    int? proteinPct,
    int? carbsPct,
    int? fatsPct,
    int? vitaminsPct,
    int? mineralsPct,
    int? fiberPct,
    String? bestMealName,
    List<String>? tips,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NutritionInsights',
      'mealsCounted': mealsCounted,
      'daysWithMeals': daysWithMeals,
      'averageHealthScore': averageHealthScore,
      'proteinPct': proteinPct,
      'carbsPct': carbsPct,
      'fatsPct': fatsPct,
      'vitaminsPct': vitaminsPct,
      'mineralsPct': mineralsPct,
      'fiberPct': fiberPct,
      if (bestMealName != null) 'bestMealName': bestMealName,
      'tips': tips.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NutritionInsights',
      'mealsCounted': mealsCounted,
      'daysWithMeals': daysWithMeals,
      'averageHealthScore': averageHealthScore,
      'proteinPct': proteinPct,
      'carbsPct': carbsPct,
      'fatsPct': fatsPct,
      'vitaminsPct': vitaminsPct,
      'mineralsPct': mineralsPct,
      'fiberPct': fiberPct,
      if (bestMealName != null) 'bestMealName': bestMealName,
      'tips': tips.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NutritionInsightsImpl extends NutritionInsights {
  _NutritionInsightsImpl({
    required int mealsCounted,
    required int daysWithMeals,
    required int averageHealthScore,
    required int proteinPct,
    required int carbsPct,
    required int fatsPct,
    required int vitaminsPct,
    required int mineralsPct,
    required int fiberPct,
    String? bestMealName,
    required List<String> tips,
  }) : super._(
         mealsCounted: mealsCounted,
         daysWithMeals: daysWithMeals,
         averageHealthScore: averageHealthScore,
         proteinPct: proteinPct,
         carbsPct: carbsPct,
         fatsPct: fatsPct,
         vitaminsPct: vitaminsPct,
         mineralsPct: mineralsPct,
         fiberPct: fiberPct,
         bestMealName: bestMealName,
         tips: tips,
       );

  /// Returns a shallow copy of this [NutritionInsights]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NutritionInsights copyWith({
    int? mealsCounted,
    int? daysWithMeals,
    int? averageHealthScore,
    int? proteinPct,
    int? carbsPct,
    int? fatsPct,
    int? vitaminsPct,
    int? mineralsPct,
    int? fiberPct,
    Object? bestMealName = _Undefined,
    List<String>? tips,
  }) {
    return NutritionInsights(
      mealsCounted: mealsCounted ?? this.mealsCounted,
      daysWithMeals: daysWithMeals ?? this.daysWithMeals,
      averageHealthScore: averageHealthScore ?? this.averageHealthScore,
      proteinPct: proteinPct ?? this.proteinPct,
      carbsPct: carbsPct ?? this.carbsPct,
      fatsPct: fatsPct ?? this.fatsPct,
      vitaminsPct: vitaminsPct ?? this.vitaminsPct,
      mineralsPct: mineralsPct ?? this.mineralsPct,
      fiberPct: fiberPct ?? this.fiberPct,
      bestMealName: bestMealName is String? ? bestMealName : this.bestMealName,
      tips: tips ?? this.tips.map((e0) => e0).toList(),
    );
  }
}

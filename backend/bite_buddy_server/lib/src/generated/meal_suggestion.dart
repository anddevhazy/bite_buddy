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

/// A meal idea that fills a gap in the pet's week.
abstract class MealSuggestion
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MealSuggestion._({
    required this.name,
    required this.reason,
    required this.boosts,
  });

  factory MealSuggestion({
    required String name,
    required String reason,
    required List<String> boosts,
  }) = _MealSuggestionImpl;

  factory MealSuggestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealSuggestion(
      name: jsonSerialization['name'] as String,
      reason: jsonSerialization['reason'] as String,
      boosts: _i61ow1lb.Protocol().deserialize<List<String>>(
        jsonSerialization['boosts'],
      ),
    );
  }

  String name;

  /// One short sentence on why it helps.
  String reason;

  /// The nutrients it boosts, e.g. protein, fiber.
  List<String> boosts;

  /// Returns a shallow copy of this [MealSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MealSuggestion copyWith({
    String? name,
    String? reason,
    List<String>? boosts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealSuggestion',
      'name': name,
      'reason': reason,
      'boosts': boosts.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealSuggestion',
      'name': name,
      'reason': reason,
      'boosts': boosts.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MealSuggestionImpl extends MealSuggestion {
  _MealSuggestionImpl({
    required String name,
    required String reason,
    required List<String> boosts,
  }) : super._(
         name: name,
         reason: reason,
         boosts: boosts,
       );

  /// Returns a shallow copy of this [MealSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MealSuggestion copyWith({
    String? name,
    String? reason,
    List<String>? boosts,
  }) {
    return MealSuggestion(
      name: name ?? this.name,
      reason: reason ?? this.reason,
      boosts: boosts ?? this.boosts.map((e0) => e0).toList(),
    );
  }
}

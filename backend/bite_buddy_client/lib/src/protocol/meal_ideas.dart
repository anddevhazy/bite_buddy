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
import 'meal_suggestion.dart' as _iymppxeh;

/// Today's AI meal ideas for one user, cached so the AI is asked at most
/// once a day.
abstract class MealIdeas
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MealIdeas._({
    this.id,
    required this.ownerId,
    required this.day,
    required this.ideas,
    required this.createdAt,
  });

  factory MealIdeas({
    int? id,
    required _isc.UuidValue ownerId,
    required DateTime day,
    required List<_iymppxeh.MealSuggestion> ideas,
    required DateTime createdAt,
  }) = _MealIdeasImpl;

  factory MealIdeas.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealIdeas(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      day: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      ideas: _i7z1njky.Protocol().deserialize<List<_iymppxeh.MealSuggestion>>(
        jsonSerialization['ideas'],
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

  _isc.UuidValue ownerId;

  /// The owner's local day (UTC midnight).
  DateTime day;

  List<_iymppxeh.MealSuggestion> ideas;

  DateTime createdAt;

  /// Returns a shallow copy of this [MealIdeas]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MealIdeas copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    DateTime? day,
    List<_iymppxeh.MealSuggestion>? ideas,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MealIdeas',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'ideas': ideas.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MealIdeas',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'day': day.toJson(),
      'ideas': ideas.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealIdeasImpl extends MealIdeas {
  _MealIdeasImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required DateTime day,
    required List<_iymppxeh.MealSuggestion> ideas,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         day: day,
         ideas: ideas,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MealIdeas]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MealIdeas copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    DateTime? day,
    List<_iymppxeh.MealSuggestion>? ideas,
    DateTime? createdAt,
  }) {
    return MealIdeas(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      day: day ?? this.day,
      ideas: ideas ?? this.ideas.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

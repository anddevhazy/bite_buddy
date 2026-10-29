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

/// A scanned meal and the nutrition the AI read from the photo.
abstract class Meal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Meal._({
    this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.calories,
    required this.proteinPct,
    required this.carbsPct,
    required this.fatsPct,
    required this.vitaminsPct,
    required this.mineralsPct,
    required this.fiberPct,
    required this.healthScore,
    required this.grade,
    required this.imageHash,
    this.photoFingerprint,
    required this.fed,
    required this.createdAt,
  });

  factory Meal({
    int? id,
    required _isc.UuidValue ownerId,
    required String name,
    required String description,
    required int calories,
    required int proteinPct,
    required int carbsPct,
    required int fatsPct,
    required int vitaminsPct,
    required int mineralsPct,
    required int fiberPct,
    required int healthScore,
    required String grade,
    required String imageHash,
    String? photoFingerprint,
    required bool fed,
    required DateTime createdAt,
  }) = _MealImpl;

  factory Meal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Meal(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      calories: jsonSerialization['calories'] as int,
      proteinPct: jsonSerialization['proteinPct'] as int,
      carbsPct: jsonSerialization['carbsPct'] as int,
      fatsPct: jsonSerialization['fatsPct'] as int,
      vitaminsPct: jsonSerialization['vitaminsPct'] as int,
      mineralsPct: jsonSerialization['mineralsPct'] as int,
      fiberPct: jsonSerialization['fiberPct'] as int,
      healthScore: jsonSerialization['healthScore'] as int,
      grade: jsonSerialization['grade'] as String,
      imageHash: jsonSerialization['imageHash'] as String,
      photoFingerprint: jsonSerialization['photoFingerprint'] as String?,
      fed: _isc.BoolJsonExtension.fromJson(jsonSerialization['fed']),
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

  String name;

  String description;

  int calories;

  /// Percent of a daily target, 0-100+.
  int proteinPct;

  int carbsPct;

  int fatsPct;

  int vitaminsPct;

  int mineralsPct;

  int fiberPct;

  /// 0-100, overall quality of the meal.
  int healthScore;

  /// A-F, from healthScore.
  String grade;

  /// SHA-256 of the uploaded photo, so the same photo can't be fed twice.
  String imageHash;

  /// Visual fingerprint (see utils/photo_fingerprint.dart), so a re-shot of
  /// the same plate can't be fed twice. Null for meals scanned before it.
  String? photoFingerprint;

  /// Whether this meal has been fed to the pet yet.
  bool fed;

  DateTime createdAt;

  /// Returns a shallow copy of this [Meal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Meal copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    String? name,
    String? description,
    int? calories,
    int? proteinPct,
    int? carbsPct,
    int? fatsPct,
    int? vitaminsPct,
    int? mineralsPct,
    int? fiberPct,
    int? healthScore,
    String? grade,
    String? imageHash,
    String? photoFingerprint,
    bool? fed,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Meal',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'name': name,
      'description': description,
      'calories': calories,
      'proteinPct': proteinPct,
      'carbsPct': carbsPct,
      'fatsPct': fatsPct,
      'vitaminsPct': vitaminsPct,
      'mineralsPct': mineralsPct,
      'fiberPct': fiberPct,
      'healthScore': healthScore,
      'grade': grade,
      'imageHash': imageHash,
      if (photoFingerprint != null) 'photoFingerprint': photoFingerprint,
      'fed': fed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Meal',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'name': name,
      'description': description,
      'calories': calories,
      'proteinPct': proteinPct,
      'carbsPct': carbsPct,
      'fatsPct': fatsPct,
      'vitaminsPct': vitaminsPct,
      'mineralsPct': mineralsPct,
      'fiberPct': fiberPct,
      'healthScore': healthScore,
      'grade': grade,
      'imageHash': imageHash,
      if (photoFingerprint != null) 'photoFingerprint': photoFingerprint,
      'fed': fed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealImpl extends Meal {
  _MealImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required String name,
    required String description,
    required int calories,
    required int proteinPct,
    required int carbsPct,
    required int fatsPct,
    required int vitaminsPct,
    required int mineralsPct,
    required int fiberPct,
    required int healthScore,
    required String grade,
    required String imageHash,
    String? photoFingerprint,
    required bool fed,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         name: name,
         description: description,
         calories: calories,
         proteinPct: proteinPct,
         carbsPct: carbsPct,
         fatsPct: fatsPct,
         vitaminsPct: vitaminsPct,
         mineralsPct: mineralsPct,
         fiberPct: fiberPct,
         healthScore: healthScore,
         grade: grade,
         imageHash: imageHash,
         photoFingerprint: photoFingerprint,
         fed: fed,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Meal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Meal copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    String? name,
    String? description,
    int? calories,
    int? proteinPct,
    int? carbsPct,
    int? fatsPct,
    int? vitaminsPct,
    int? mineralsPct,
    int? fiberPct,
    int? healthScore,
    String? grade,
    String? imageHash,
    Object? photoFingerprint = _Undefined,
    bool? fed,
    DateTime? createdAt,
  }) {
    return Meal(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      proteinPct: proteinPct ?? this.proteinPct,
      carbsPct: carbsPct ?? this.carbsPct,
      fatsPct: fatsPct ?? this.fatsPct,
      vitaminsPct: vitaminsPct ?? this.vitaminsPct,
      mineralsPct: mineralsPct ?? this.mineralsPct,
      fiberPct: fiberPct ?? this.fiberPct,
      healthScore: healthScore ?? this.healthScore,
      grade: grade ?? this.grade,
      imageHash: imageHash ?? this.imageHash,
      photoFingerprint: photoFingerprint is String?
          ? photoFingerprint
          : this.photoFingerprint,
      fed: fed ?? this.fed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

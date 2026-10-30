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
import 'dart:typed_data' as _idt;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// A picture of the user's real pet, redrawn as their buddy. Drafts that were
/// never used are cleaned up after a day; used ones are kept because old
/// friend battles still show them.
abstract class PetPortrait
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PetPortrait._({
    this.id,
    required this.ownerId,
    required this.image,
    required this.animal,
    required this.used,
    required this.createdAt,
  });

  factory PetPortrait({
    int? id,
    required _isc.UuidValue ownerId,
    required _idt.ByteData image,
    required String animal,
    required bool used,
    required DateTime createdAt,
  }) = _PetPortraitImpl;

  factory PetPortrait.fromJson(Map<String, dynamic> jsonSerialization) {
    return PetPortrait(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      image: _isc.ByteDataJsonExtension.fromJson(jsonSerialization['image']),
      animal: jsonSerialization['animal'] as String,
      used: _isc.BoolJsonExtension.fromJson(jsonSerialization['used']),
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

  /// PNG or JPEG bytes.
  _idt.ByteData image;

  /// What the AI saw, e.g. "dog", "cat", "rabbit".
  String animal;

  /// True once it has been put on the owner's pet.
  bool used;

  DateTime createdAt;

  /// Returns a shallow copy of this [PetPortrait]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PetPortrait copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    _idt.ByteData? image,
    String? animal,
    bool? used,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PetPortrait',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'image': image.toJson(),
      'animal': animal,
      'used': used,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PetPortrait',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'image': image.toJson(),
      'animal': animal,
      'used': used,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PetPortraitImpl extends PetPortrait {
  _PetPortraitImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required _idt.ByteData image,
    required String animal,
    required bool used,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         image: image,
         animal: animal,
         used: used,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PetPortrait]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PetPortrait copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    _idt.ByteData? image,
    String? animal,
    bool? used,
    DateTime? createdAt,
  }) {
    return PetPortrait(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      image: image ?? this.image.clone(),
      animal: animal ?? this.animal,
      used: used ?? this.used,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

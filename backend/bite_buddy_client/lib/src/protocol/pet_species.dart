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

/// A pet the user can adopt. Served from the catalog in utils/catalog.dart.
abstract class PetSpecies
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PetSpecies._({
    required this.key,
    required this.name,
    required this.title,
    required this.rarity,
    required this.emoji,
  });

  factory PetSpecies({
    required String key,
    required String name,
    required String title,
    required String rarity,
    required String emoji,
  }) = _PetSpeciesImpl;

  factory PetSpecies.fromJson(Map<String, dynamic> jsonSerialization) {
    return PetSpecies(
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String,
      title: jsonSerialization['title'] as String,
      rarity: jsonSerialization['rarity'] as String,
      emoji: jsonSerialization['emoji'] as String,
    );
  }

  String key;

  String name;

  String title;

  String rarity;

  String emoji;

  /// Returns a shallow copy of this [PetSpecies]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PetSpecies copyWith({
    String? key,
    String? name,
    String? title,
    String? rarity,
    String? emoji,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PetSpecies',
      'key': key,
      'name': name,
      'title': title,
      'rarity': rarity,
      'emoji': emoji,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PetSpecies',
      'key': key,
      'name': name,
      'title': title,
      'rarity': rarity,
      'emoji': emoji,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PetSpeciesImpl extends PetSpecies {
  _PetSpeciesImpl({
    required String key,
    required String name,
    required String title,
    required String rarity,
    required String emoji,
  }) : super._(
         key: key,
         name: name,
         title: title,
         rarity: rarity,
         emoji: emoji,
       );

  /// Returns a shallow copy of this [PetSpecies]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PetSpecies copyWith({
    String? key,
    String? name,
    String? title,
    String? rarity,
    String? emoji,
  }) {
    return PetSpecies(
      key: key ?? this.key,
      name: name ?? this.name,
      title: title ?? this.title,
      rarity: rarity ?? this.rarity,
      emoji: emoji ?? this.emoji,
    );
  }
}

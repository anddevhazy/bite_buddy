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

/// A player's wallet on Base, where their keepsakes are minted.
abstract class CryptoWallet
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CryptoWallet._({
    this.id,
    required this.ownerId,
    required this.address,
    required this.isTest,
    required this.showPetPhoto,
    required this.createdAt,
  });

  factory CryptoWallet({
    int? id,
    required _isc.UuidValue ownerId,
    required String address,
    required bool isTest,
    required bool showPetPhoto,
    required DateTime createdAt,
  }) = _CryptoWalletImpl;

  factory CryptoWallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return CryptoWallet(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      address: jsonSerialization['address'] as String,
      isTest: _isc.BoolJsonExtension.fromJson(jsonSerialization['isTest']),
      showPetPhoto: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['showPetPhoto'],
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

  /// 0x-prefixed, lowercase.
  String address;

  /// True for a stand-in wallet made while no wallet provider is set up:
  /// nothing minted to it is on a real blockchain.
  bool isTest;

  /// Whether their own pet's photo ("My own pet") may appear on their
  /// keepsakes, which are public. Otherwise a paw card is used.
  bool showPetPhoto;

  DateTime createdAt;

  /// Returns a shallow copy of this [CryptoWallet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CryptoWallet copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    String? address,
    bool? isTest,
    bool? showPetPhoto,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CryptoWallet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'address': address,
      'isTest': isTest,
      'showPetPhoto': showPetPhoto,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CryptoWallet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'address': address,
      'isTest': isTest,
      'showPetPhoto': showPetPhoto,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CryptoWalletImpl extends CryptoWallet {
  _CryptoWalletImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required String address,
    required bool isTest,
    required bool showPetPhoto,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         address: address,
         isTest: isTest,
         showPetPhoto: showPetPhoto,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CryptoWallet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CryptoWallet copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    String? address,
    bool? isTest,
    bool? showPetPhoto,
    DateTime? createdAt,
  }) {
    return CryptoWallet(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      address: address ?? this.address,
      isTest: isTest ?? this.isTest,
      showPetPhoto: showPetPhoto ?? this.showPetPhoto,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

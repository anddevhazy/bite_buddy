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

/// The caller's wallet, as the app shows it.
abstract class WalletView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  WalletView._({
    required this.address,
    required this.isTest,
    required this.networkName,
    required this.showPetPhoto,
    this.explorerUrl,
  });

  factory WalletView({
    required String address,
    required bool isTest,
    required String networkName,
    required bool showPetPhoto,
    String? explorerUrl,
  }) = _WalletViewImpl;

  factory WalletView.fromJson(Map<String, dynamic> jsonSerialization) {
    return WalletView(
      address: jsonSerialization['address'] as String,
      isTest: _isc.BoolJsonExtension.fromJson(jsonSerialization['isTest']),
      networkName: jsonSerialization['networkName'] as String,
      showPetPhoto: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['showPetPhoto'],
      ),
      explorerUrl: jsonSerialization['explorerUrl'] as String?,
    );
  }

  String address;

  bool isTest;

  /// e.g. "Base" or "Test mode"
  String networkName;

  bool showPetPhoto;

  /// Link to the wallet on a block explorer; null in test mode.
  String? explorerUrl;

  /// Returns a shallow copy of this [WalletView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  WalletView copyWith({
    String? address,
    bool? isTest,
    String? networkName,
    bool? showPetPhoto,
    String? explorerUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WalletView',
      'address': address,
      'isTest': isTest,
      'networkName': networkName,
      'showPetPhoto': showPetPhoto,
      if (explorerUrl != null) 'explorerUrl': explorerUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WalletView',
      'address': address,
      'isTest': isTest,
      'networkName': networkName,
      'showPetPhoto': showPetPhoto,
      if (explorerUrl != null) 'explorerUrl': explorerUrl,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletViewImpl extends WalletView {
  _WalletViewImpl({
    required String address,
    required bool isTest,
    required String networkName,
    required bool showPetPhoto,
    String? explorerUrl,
  }) : super._(
         address: address,
         isTest: isTest,
         networkName: networkName,
         showPetPhoto: showPetPhoto,
         explorerUrl: explorerUrl,
       );

  /// Returns a shallow copy of this [WalletView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  WalletView copyWith({
    String? address,
    bool? isTest,
    String? networkName,
    bool? showPetPhoto,
    Object? explorerUrl = _Undefined,
  }) {
    return WalletView(
      address: address ?? this.address,
      isTest: isTest ?? this.isTest,
      networkName: networkName ?? this.networkName,
      showPetPhoto: showPetPhoto ?? this.showPetPhoto,
      explorerUrl: explorerUrl is String? ? explorerUrl : this.explorerUrl,
    );
  }
}

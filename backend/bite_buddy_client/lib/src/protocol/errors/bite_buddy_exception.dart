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

/// Thrown by endpoints for errors the app should show to the user. Serverpod
/// sends it to the client as a typed exception.
abstract class BiteBuddyException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  BiteBuddyException._({
    required this.code,
    required this.message,
  });

  factory BiteBuddyException({
    required String code,
    required String message,
  }) = _BiteBuddyExceptionImpl;

  factory BiteBuddyException.fromJson(Map<String, dynamic> jsonSerialization) {
    return BiteBuddyException(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  /// NO_PET, PET_EXISTS, MEAL_REJECTED, ALREADY_FED, DUPLICATE_PHOTO,
  /// NOT_ENOUGH_ENERGY, NOT_FOUND, INVALID_INPUT, AI_UNAVAILABLE
  String code;

  String message;

  /// Returns a shallow copy of this [BiteBuddyException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BiteBuddyException copyWith({
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BiteBuddyException',
      'code': code,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BiteBuddyException',
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'BiteBuddyException(code: $code, message: $message)';
  }
}

class _BiteBuddyExceptionImpl extends BiteBuddyException {
  _BiteBuddyExceptionImpl({
    required String code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [BiteBuddyException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BiteBuddyException copyWith({
    String? code,
    String? message,
  }) {
    return BiteBuddyException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}

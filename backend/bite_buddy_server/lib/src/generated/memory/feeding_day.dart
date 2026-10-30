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

/// One local day on the feeding calendar.
abstract class FeedingDay
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeedingDay._({
    required this.day,
    required this.meals,
    required this.averageScore,
  });

  factory FeedingDay({
    required DateTime day,
    required int meals,
    required int averageScore,
  }) = _FeedingDayImpl;

  factory FeedingDay.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedingDay(
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      meals: jsonSerialization['meals'] as int,
      averageScore: jsonSerialization['averageScore'] as int,
    );
  }

  /// The owner's local day (UTC midnight).
  DateTime day;

  int meals;

  /// Average health score of the day's meals, 0 with no meals.
  int averageScore;

  /// Returns a shallow copy of this [FeedingDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedingDay copyWith({
    DateTime? day,
    int? meals,
    int? averageScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedingDay',
      'day': day.toJson(),
      'meals': meals,
      'averageScore': averageScore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedingDay',
      'day': day.toJson(),
      'meals': meals,
      'averageScore': averageScore,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FeedingDayImpl extends FeedingDay {
  _FeedingDayImpl({
    required DateTime day,
    required int meals,
    required int averageScore,
  }) : super._(
         day: day,
         meals: meals,
         averageScore: averageScore,
       );

  /// Returns a shallow copy of this [FeedingDay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedingDay copyWith({
    DateTime? day,
    int? meals,
    int? averageScore,
  }) {
    return FeedingDay(
      day: day ?? this.day,
      meals: meals ?? this.meals,
      averageScore: averageScore ?? this.averageScore,
    );
  }
}

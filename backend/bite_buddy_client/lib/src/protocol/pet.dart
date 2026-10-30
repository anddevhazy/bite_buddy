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

/// A user's pet. One per user; every stat is 0-100 except level, xp and coins.
abstract class Pet
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Pet._({
    this.id,
    required this.ownerId,
    required this.speciesKey,
    required this.name,
    this.portraitId,
    required this.level,
    required this.xp,
    required this.health,
    required this.energy,
    required this.nutrition,
    required this.coins,
    required this.mealsEaten,
    required this.wins,
    required this.losses,
    this.lastFedAt,
    int? streak,
    int? bestStreak,
    this.lastStreakDay,
    int? utcOffsetMinutes,
    required this.lastDecayAt,
    required this.createdAt,
  }) : streak = streak ?? 0,
       bestStreak = bestStreak ?? 0,
       utcOffsetMinutes = utcOffsetMinutes ?? 0;

  factory Pet({
    int? id,
    required _isc.UuidValue ownerId,
    required String speciesKey,
    required String name,
    int? portraitId,
    required int level,
    required int xp,
    required int health,
    required int energy,
    required int nutrition,
    required int coins,
    required int mealsEaten,
    required int wins,
    required int losses,
    DateTime? lastFedAt,
    int? streak,
    int? bestStreak,
    DateTime? lastStreakDay,
    int? utcOffsetMinutes,
    required DateTime lastDecayAt,
    required DateTime createdAt,
  }) = _PetImpl;

  factory Pet.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pet(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      speciesKey: jsonSerialization['speciesKey'] as String,
      name: jsonSerialization['name'] as String,
      portraitId: jsonSerialization['portraitId'] as int?,
      level: jsonSerialization['level'] as int,
      xp: jsonSerialization['xp'] as int,
      health: jsonSerialization['health'] as int,
      energy: jsonSerialization['energy'] as int,
      nutrition: jsonSerialization['nutrition'] as int,
      coins: jsonSerialization['coins'] as int,
      mealsEaten: jsonSerialization['mealsEaten'] as int,
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
      lastFedAt: jsonSerialization['lastFedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['lastFedAt']),
      streak: jsonSerialization['streak'] as int?,
      bestStreak: jsonSerialization['bestStreak'] as int?,
      lastStreakDay: jsonSerialization['lastStreakDay'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStreakDay'],
            ),
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int?,
      lastDecayAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastDecayAt'],
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

  /// The auth user that owns this pet.
  _isc.UuidValue ownerId;

  /// Key into the species catalog (fluffy, sparkle, thunder, mystic).
  String speciesKey;

  String name;

  /// The user's own pet, redrawn (see PetPortrait). Shown instead of the
  /// species picture when set; the species still decides nothing else.
  int? portraitId;

  int level;

  /// XP towards the next level; a level needs level * 100 XP.
  int xp;

  int health;

  int energy;

  /// Rolling meal quality. This is the leaderboard score.
  int nutrition;

  int coins;

  int mealsEaten;

  int wins;

  int losses;

  DateTime? lastFedAt;

  /// Days in a row the pet has eaten, in the owner's local time. Missing a
  /// whole day resets it to 0.
  int streak;

  int bestStreak;

  /// The last local day (stored as UTC midnight) that counted for the streak.
  DateTime? lastStreakDay;

  /// The owner's UTC offset at their last feed, so the server knows when
  /// their day starts and ends.
  int utcOffsetMinutes;

  /// Neglect decay has been applied up to this moment.
  DateTime lastDecayAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Pet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Pet copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    String? speciesKey,
    String? name,
    int? portraitId,
    int? level,
    int? xp,
    int? health,
    int? energy,
    int? nutrition,
    int? coins,
    int? mealsEaten,
    int? wins,
    int? losses,
    DateTime? lastFedAt,
    int? streak,
    int? bestStreak,
    DateTime? lastStreakDay,
    int? utcOffsetMinutes,
    DateTime? lastDecayAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Pet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'speciesKey': speciesKey,
      'name': name,
      if (portraitId != null) 'portraitId': portraitId,
      'level': level,
      'xp': xp,
      'health': health,
      'energy': energy,
      'nutrition': nutrition,
      'coins': coins,
      'mealsEaten': mealsEaten,
      'wins': wins,
      'losses': losses,
      if (lastFedAt != null) 'lastFedAt': lastFedAt?.toJson(),
      'streak': streak,
      'bestStreak': bestStreak,
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
      'lastDecayAt': lastDecayAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Pet',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'speciesKey': speciesKey,
      'name': name,
      if (portraitId != null) 'portraitId': portraitId,
      'level': level,
      'xp': xp,
      'health': health,
      'energy': energy,
      'nutrition': nutrition,
      'coins': coins,
      'mealsEaten': mealsEaten,
      'wins': wins,
      'losses': losses,
      if (lastFedAt != null) 'lastFedAt': lastFedAt?.toJson(),
      'streak': streak,
      'bestStreak': bestStreak,
      if (lastStreakDay != null) 'lastStreakDay': lastStreakDay?.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
      'lastDecayAt': lastDecayAt.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PetImpl extends Pet {
  _PetImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required String speciesKey,
    required String name,
    int? portraitId,
    required int level,
    required int xp,
    required int health,
    required int energy,
    required int nutrition,
    required int coins,
    required int mealsEaten,
    required int wins,
    required int losses,
    DateTime? lastFedAt,
    int? streak,
    int? bestStreak,
    DateTime? lastStreakDay,
    int? utcOffsetMinutes,
    required DateTime lastDecayAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         speciesKey: speciesKey,
         name: name,
         portraitId: portraitId,
         level: level,
         xp: xp,
         health: health,
         energy: energy,
         nutrition: nutrition,
         coins: coins,
         mealsEaten: mealsEaten,
         wins: wins,
         losses: losses,
         lastFedAt: lastFedAt,
         streak: streak,
         bestStreak: bestStreak,
         lastStreakDay: lastStreakDay,
         utcOffsetMinutes: utcOffsetMinutes,
         lastDecayAt: lastDecayAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Pet]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Pet copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    String? speciesKey,
    String? name,
    Object? portraitId = _Undefined,
    int? level,
    int? xp,
    int? health,
    int? energy,
    int? nutrition,
    int? coins,
    int? mealsEaten,
    int? wins,
    int? losses,
    Object? lastFedAt = _Undefined,
    int? streak,
    int? bestStreak,
    Object? lastStreakDay = _Undefined,
    int? utcOffsetMinutes,
    DateTime? lastDecayAt,
    DateTime? createdAt,
  }) {
    return Pet(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      speciesKey: speciesKey ?? this.speciesKey,
      name: name ?? this.name,
      portraitId: portraitId is int? ? portraitId : this.portraitId,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      health: health ?? this.health,
      energy: energy ?? this.energy,
      nutrition: nutrition ?? this.nutrition,
      coins: coins ?? this.coins,
      mealsEaten: mealsEaten ?? this.mealsEaten,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      lastFedAt: lastFedAt is DateTime? ? lastFedAt : this.lastFedAt,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastStreakDay: lastStreakDay is DateTime?
          ? lastStreakDay
          : this.lastStreakDay,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
      lastDecayAt: lastDecayAt ?? this.lastDecayAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

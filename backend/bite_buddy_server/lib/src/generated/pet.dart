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

/// A user's pet. One per user; every stat is 0-100 except level, xp and coins.
abstract class Pet implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Pet._({
    this.id,
    required this.ownerId,
    required this.speciesKey,
    required this.name,
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
    required _is.UuidValue ownerId,
    required String speciesKey,
    required String name,
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
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      speciesKey: jsonSerialization['speciesKey'] as String,
      name: jsonSerialization['name'] as String,
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastFedAt']),
      streak: jsonSerialization['streak'] as int?,
      bestStreak: jsonSerialization['bestStreak'] as int?,
      lastStreakDay: jsonSerialization['lastStreakDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStreakDay'],
            ),
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int?,
      lastDecayAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastDecayAt'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PetTable();

  static const db = PetRepository._();

  @override
  int? id;

  /// The auth user that owns this pet.
  _is.UuidValue ownerId;

  /// Key into the species catalog (fluffy, sparkle, thunder, mystic).
  String speciesKey;

  String name;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Pet]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Pet copyWith({
    int? id,
    _is.UuidValue? ownerId,
    String? speciesKey,
    String? name,
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

  static PetInclude include() {
    return PetInclude._();
  }

  static PetIncludeList includeList({
    _is.WhereExpressionBuilder<PetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    PetInclude? include,
  }) {
    return PetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PetImpl extends Pet {
  _PetImpl({
    int? id,
    required _is.UuidValue ownerId,
    required String speciesKey,
    required String name,
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
  @_is.useResult
  @override
  Pet copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
    String? speciesKey,
    String? name,
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

class PetUpdateTable extends _is.UpdateTable<PetTable> {
  PetUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> speciesKey(String value) => _is.ColumnValue(
    table.speciesKey,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> level(int value) => _is.ColumnValue(
    table.level,
    value,
  );

  _is.ColumnValue<int, int> xp(int value) => _is.ColumnValue(
    table.xp,
    value,
  );

  _is.ColumnValue<int, int> health(int value) => _is.ColumnValue(
    table.health,
    value,
  );

  _is.ColumnValue<int, int> energy(int value) => _is.ColumnValue(
    table.energy,
    value,
  );

  _is.ColumnValue<int, int> nutrition(int value) => _is.ColumnValue(
    table.nutrition,
    value,
  );

  _is.ColumnValue<int, int> coins(int value) => _is.ColumnValue(
    table.coins,
    value,
  );

  _is.ColumnValue<int, int> mealsEaten(int value) => _is.ColumnValue(
    table.mealsEaten,
    value,
  );

  _is.ColumnValue<int, int> wins(int value) => _is.ColumnValue(
    table.wins,
    value,
  );

  _is.ColumnValue<int, int> losses(int value) => _is.ColumnValue(
    table.losses,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastFedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastFedAt,
        value,
      );

  _is.ColumnValue<int, int> streak(int value) => _is.ColumnValue(
    table.streak,
    value,
  );

  _is.ColumnValue<int, int> bestStreak(int value) => _is.ColumnValue(
    table.bestStreak,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastStreakDay(DateTime? value) =>
      _is.ColumnValue(
        table.lastStreakDay,
        value,
      );

  _is.ColumnValue<int, int> utcOffsetMinutes(int value) => _is.ColumnValue(
    table.utcOffsetMinutes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastDecayAt(DateTime value) =>
      _is.ColumnValue(
        table.lastDecayAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PetTable extends _is.Table<int?> {
  PetTable({super.tableRelation}) : super(tableName: 'pet') {
    updateTable = PetUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    speciesKey = _is.ColumnString(
      'speciesKey',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    level = _is.ColumnInt(
      'level',
      this,
    );
    xp = _is.ColumnInt(
      'xp',
      this,
    );
    health = _is.ColumnInt(
      'health',
      this,
    );
    energy = _is.ColumnInt(
      'energy',
      this,
    );
    nutrition = _is.ColumnInt(
      'nutrition',
      this,
    );
    coins = _is.ColumnInt(
      'coins',
      this,
    );
    mealsEaten = _is.ColumnInt(
      'mealsEaten',
      this,
    );
    wins = _is.ColumnInt(
      'wins',
      this,
    );
    losses = _is.ColumnInt(
      'losses',
      this,
    );
    lastFedAt = _is.ColumnDateTime(
      'lastFedAt',
      this,
    );
    streak = _is.ColumnInt(
      'streak',
      this,
      hasDefault: true,
    );
    bestStreak = _is.ColumnInt(
      'bestStreak',
      this,
      hasDefault: true,
    );
    lastStreakDay = _is.ColumnDateTime(
      'lastStreakDay',
      this,
    );
    utcOffsetMinutes = _is.ColumnInt(
      'utcOffsetMinutes',
      this,
      hasDefault: true,
    );
    lastDecayAt = _is.ColumnDateTime(
      'lastDecayAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PetUpdateTable updateTable;

  /// The auth user that owns this pet.
  late final _is.ColumnUuid ownerId;

  /// Key into the species catalog (fluffy, sparkle, thunder, mystic).
  late final _is.ColumnString speciesKey;

  late final _is.ColumnString name;

  late final _is.ColumnInt level;

  /// XP towards the next level; a level needs level * 100 XP.
  late final _is.ColumnInt xp;

  late final _is.ColumnInt health;

  late final _is.ColumnInt energy;

  /// Rolling meal quality. This is the leaderboard score.
  late final _is.ColumnInt nutrition;

  late final _is.ColumnInt coins;

  late final _is.ColumnInt mealsEaten;

  late final _is.ColumnInt wins;

  late final _is.ColumnInt losses;

  late final _is.ColumnDateTime lastFedAt;

  /// Days in a row the pet has eaten, in the owner's local time. Missing a
  /// whole day resets it to 0.
  late final _is.ColumnInt streak;

  late final _is.ColumnInt bestStreak;

  /// The last local day (stored as UTC midnight) that counted for the streak.
  late final _is.ColumnDateTime lastStreakDay;

  /// The owner's UTC offset at their last feed, so the server knows when
  /// their day starts and ends.
  late final _is.ColumnInt utcOffsetMinutes;

  /// Neglect decay has been applied up to this moment.
  late final _is.ColumnDateTime lastDecayAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    speciesKey,
    name,
    level,
    xp,
    health,
    energy,
    nutrition,
    coins,
    mealsEaten,
    wins,
    losses,
    lastFedAt,
    streak,
    bestStreak,
    lastStreakDay,
    utcOffsetMinutes,
    lastDecayAt,
    createdAt,
  ];
}

class PetInclude extends _is.IncludeObject {
  PetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Pet.t;
}

class PetIncludeList extends _is.IncludeList {
  PetIncludeList._({
    _is.WhereExpressionBuilder<PetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Pet.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Pet.t;
}

class PetRepository {
  const PetRepository._();

  /// Returns a list of [Pet]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Pet>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Pet>(
      where: where?.call(Pet.t),
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Pet] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Pet?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetTable>? where,
    int? offset,
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Pet>(
      where: where?.call(Pet.t),
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Pet] by its [id] or null if no such row exists.
  Future<Pet?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Pet>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Pet]s in the list and returns the inserted rows.
  ///
  /// The returned [Pet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> insert(
    _is.DatabaseSession session,
    List<Pet> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Pet>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Pet] and returns the inserted row.
  ///
  /// The returned [Pet] will have its `id` field set.
  Future<Pet> insertRow(
    _is.DatabaseSession session,
    Pet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Pet>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Pet]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Pet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> upsert(
    _is.DatabaseSession session,
    List<Pet> rows, {
    required _is.ColumnSelections<PetTable> conflictColumns,
    _is.ColumnSelections<PetTable>? updateColumns,
    _is.WhereExpressionBuilder<PetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Pet>(
      rows,
      conflictColumns: conflictColumns(Pet.t),
      updateColumns: updateColumns?.call(Pet.t),
      updateWhere: updateWhere?.call(Pet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Pet] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Pet] will have its `id` field set.
  Future<Pet?> upsertRow(
    _is.DatabaseSession session,
    Pet row, {
    required _is.ColumnSelections<PetTable> conflictColumns,
    _is.ColumnSelections<PetTable>? updateColumns,
    _is.WhereExpressionBuilder<PetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Pet>(
      row,
      conflictColumns: conflictColumns(Pet.t),
      updateColumns: updateColumns?.call(Pet.t),
      updateWhere: updateWhere?.call(Pet.t),
      transaction: transaction,
    );
  }

  /// Updates all [Pet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> update(
    _is.DatabaseSession session,
    List<Pet> rows, {
    _is.ColumnSelections<PetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Pet>(
      rows,
      columns: columns?.call(Pet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Pet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Pet> updateRow(
    _is.DatabaseSession session,
    Pet row, {
    _is.ColumnSelections<PetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Pet>(
      row,
      columns: columns?.call(Pet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Pet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Pet?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Pet>(
      id,
      columnValues: columnValues(Pet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Pet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Pet>(
      columnValues: columnValues(Pet.t.updateTable),
      where: where(Pet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Pet]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> delete(
    _is.DatabaseSession session,
    List<Pet> rows, {
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Pet>(
      rows,
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Pet].
  Future<Pet> deleteRow(
    _is.DatabaseSession session,
    Pet row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Pet>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pet>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PetTable> where,
    _is.OrderByBuilder<PetTable>? orderBy,
    _is.OrderByListBuilder<PetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Pet>(
      where: where(Pet.t),
      orderBy: orderBy?.call(Pet.t),
      orderByList: orderByList?.call(Pet.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Pet>(
      where: where?.call(Pet.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Pet] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Pet>(
      where: where(Pet.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

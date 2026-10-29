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

/// A scanned meal and the nutrition the AI read from the photo.
abstract class Meal implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue ownerId,
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
      ownerId: _is.UuidValueJsonExtension.fromJson(
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
      fed: _is.BoolJsonExtension.fromJson(jsonSerialization['fed']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MealTable();

  static const db = MealRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Meal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Meal copyWith({
    int? id,
    _is.UuidValue? ownerId,
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

  static MealInclude include() {
    return MealInclude._();
  }

  static MealIncludeList includeList({
    _is.WhereExpressionBuilder<MealTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    MealInclude? include,
  }) {
    return MealIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealImpl extends Meal {
  _MealImpl({
    int? id,
    required _is.UuidValue ownerId,
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
  @_is.useResult
  @override
  Meal copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
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

class MealUpdateTable extends _is.UpdateTable<MealTable> {
  MealUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> calories(int value) => _is.ColumnValue(
    table.calories,
    value,
  );

  _is.ColumnValue<int, int> proteinPct(int value) => _is.ColumnValue(
    table.proteinPct,
    value,
  );

  _is.ColumnValue<int, int> carbsPct(int value) => _is.ColumnValue(
    table.carbsPct,
    value,
  );

  _is.ColumnValue<int, int> fatsPct(int value) => _is.ColumnValue(
    table.fatsPct,
    value,
  );

  _is.ColumnValue<int, int> vitaminsPct(int value) => _is.ColumnValue(
    table.vitaminsPct,
    value,
  );

  _is.ColumnValue<int, int> mineralsPct(int value) => _is.ColumnValue(
    table.mineralsPct,
    value,
  );

  _is.ColumnValue<int, int> fiberPct(int value) => _is.ColumnValue(
    table.fiberPct,
    value,
  );

  _is.ColumnValue<int, int> healthScore(int value) => _is.ColumnValue(
    table.healthScore,
    value,
  );

  _is.ColumnValue<String, String> grade(String value) => _is.ColumnValue(
    table.grade,
    value,
  );

  _is.ColumnValue<String, String> imageHash(String value) => _is.ColumnValue(
    table.imageHash,
    value,
  );

  _is.ColumnValue<String, String> photoFingerprint(String? value) =>
      _is.ColumnValue(
        table.photoFingerprint,
        value,
      );

  _is.ColumnValue<bool, bool> fed(bool value) => _is.ColumnValue(
    table.fed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MealTable extends _is.Table<int?> {
  MealTable({super.tableRelation}) : super(tableName: 'meal') {
    updateTable = MealUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    calories = _is.ColumnInt(
      'calories',
      this,
    );
    proteinPct = _is.ColumnInt(
      'proteinPct',
      this,
    );
    carbsPct = _is.ColumnInt(
      'carbsPct',
      this,
    );
    fatsPct = _is.ColumnInt(
      'fatsPct',
      this,
    );
    vitaminsPct = _is.ColumnInt(
      'vitaminsPct',
      this,
    );
    mineralsPct = _is.ColumnInt(
      'mineralsPct',
      this,
    );
    fiberPct = _is.ColumnInt(
      'fiberPct',
      this,
    );
    healthScore = _is.ColumnInt(
      'healthScore',
      this,
    );
    grade = _is.ColumnString(
      'grade',
      this,
    );
    imageHash = _is.ColumnString(
      'imageHash',
      this,
    );
    photoFingerprint = _is.ColumnString(
      'photoFingerprint',
      this,
    );
    fed = _is.ColumnBool(
      'fed',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MealUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnInt calories;

  /// Percent of a daily target, 0-100+.
  late final _is.ColumnInt proteinPct;

  late final _is.ColumnInt carbsPct;

  late final _is.ColumnInt fatsPct;

  late final _is.ColumnInt vitaminsPct;

  late final _is.ColumnInt mineralsPct;

  late final _is.ColumnInt fiberPct;

  /// 0-100, overall quality of the meal.
  late final _is.ColumnInt healthScore;

  /// A-F, from healthScore.
  late final _is.ColumnString grade;

  /// SHA-256 of the uploaded photo, so the same photo can't be fed twice.
  late final _is.ColumnString imageHash;

  /// Visual fingerprint (see utils/photo_fingerprint.dart), so a re-shot of
  /// the same plate can't be fed twice. Null for meals scanned before it.
  late final _is.ColumnString photoFingerprint;

  /// Whether this meal has been fed to the pet yet.
  late final _is.ColumnBool fed;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    name,
    description,
    calories,
    proteinPct,
    carbsPct,
    fatsPct,
    vitaminsPct,
    mineralsPct,
    fiberPct,
    healthScore,
    grade,
    imageHash,
    photoFingerprint,
    fed,
    createdAt,
  ];
}

class MealInclude extends _is.IncludeObject {
  MealInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Meal.t;
}

class MealIncludeList extends _is.IncludeList {
  MealIncludeList._({
    _is.WhereExpressionBuilder<MealTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Meal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Meal.t;
}

class MealRepository {
  const MealRepository._();

  /// Returns a list of [Meal]s matching the given query parameters.
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
  Future<List<Meal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Meal>(
      where: where?.call(Meal.t),
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Meal] matching the given query parameters.
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
  Future<Meal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealTable>? where,
    int? offset,
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Meal>(
      where: where?.call(Meal.t),
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Meal] by its [id] or null if no such row exists.
  Future<Meal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Meal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Meal]s in the list and returns the inserted rows.
  ///
  /// The returned [Meal]s will have their `id` fields set.
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
  Future<List<Meal>> insert(
    _is.DatabaseSession session,
    List<Meal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Meal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Meal] and returns the inserted row.
  ///
  /// The returned [Meal] will have its `id` field set.
  Future<Meal> insertRow(
    _is.DatabaseSession session,
    Meal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Meal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Meal]s in the list and returns the resulting rows.
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
  /// The returned [Meal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Meal>> upsert(
    _is.DatabaseSession session,
    List<Meal> rows, {
    required _is.ColumnSelections<MealTable> conflictColumns,
    _is.ColumnSelections<MealTable>? updateColumns,
    _is.WhereExpressionBuilder<MealTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Meal>(
      rows,
      conflictColumns: conflictColumns(Meal.t),
      updateColumns: updateColumns?.call(Meal.t),
      updateWhere: updateWhere?.call(Meal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Meal] and returns the resulting row.
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
  /// The returned [Meal] will have its `id` field set.
  Future<Meal?> upsertRow(
    _is.DatabaseSession session,
    Meal row, {
    required _is.ColumnSelections<MealTable> conflictColumns,
    _is.ColumnSelections<MealTable>? updateColumns,
    _is.WhereExpressionBuilder<MealTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Meal>(
      row,
      conflictColumns: conflictColumns(Meal.t),
      updateColumns: updateColumns?.call(Meal.t),
      updateWhere: updateWhere?.call(Meal.t),
      transaction: transaction,
    );
  }

  /// Updates all [Meal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Meal>> update(
    _is.DatabaseSession session,
    List<Meal> rows, {
    _is.ColumnSelections<MealTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Meal>(
      rows,
      columns: columns?.call(Meal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Meal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Meal> updateRow(
    _is.DatabaseSession session,
    Meal row, {
    _is.ColumnSelections<MealTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Meal>(
      row,
      columns: columns?.call(Meal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Meal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Meal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MealUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Meal>(
      id,
      columnValues: columnValues(Meal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Meal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Meal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MealUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MealTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Meal>(
      columnValues: columnValues(Meal.t.updateTable),
      where: where(Meal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Meal]s in the list and returns the deleted rows.
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
  Future<List<Meal>> delete(
    _is.DatabaseSession session,
    List<Meal> rows, {
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Meal>(
      rows,
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Meal].
  Future<Meal> deleteRow(
    _is.DatabaseSession session,
    Meal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Meal>(
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
  Future<List<Meal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealTable> where,
    _is.OrderByBuilder<MealTable>? orderBy,
    _is.OrderByListBuilder<MealTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Meal>(
      where: where(Meal.t),
      orderBy: orderBy?.call(Meal.t),
      orderByList: orderByList?.call(Meal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MealTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Meal>(
      where: where?.call(Meal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Meal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MealTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Meal>(
      where: where(Meal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

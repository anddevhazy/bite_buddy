import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../errors/app_errors.dart';
import '../generated/protocol.dart';
import '../utils/season.dart';
import 'duel_service.dart';
import 'pet_service.dart';

// Friend leagues and their weekly seasons. Finished seasons are settled
// lazily, the next time anyone in the league opens it; the unique index on
// SeasonResult makes sure each season is only ever paid out once.
class LeagueService {
  final PetService pets;
  final DuelService duels;
  final Random _rng;

  LeagueService({required this.pets, required this.duels, Random? rng})
    : _rng = rng ?? Random.secure();

  // Settle at most this many missed weeks at once (for long-idle leagues)
  static const int _maxWeeksToSettle = 8;
  // No 0/O or 1/I, so codes are easy to read out and type
  static const String _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  Future<LeagueDetail> create(
    Session session,
    UuidValue userId,
    String name,
  ) async {
    final trimmed = name.trim();
    if (trimmed.length < 2 || trimmed.length > 30) {
      throw invalidInputError('League names must be 2 to 30 characters.');
    }
    await pets.requireMine(session, userId);

    final now = DateTime.now().toUtc();
    final league = await session.db.transaction((transaction) async {
      for (var attempt = 0; ; attempt++) {
        try {
          final league = await League.db.insertRow(
            session,
            League(
              name: trimmed,
              inviteCode: _newCode(),
              ownerId: userId,
              createdAt: now,
            ),
            transaction: transaction,
          );
          await LeagueMember.db.insertRow(
            session,
            LeagueMember(leagueId: league.id!, userId: userId, joinedAt: now),
            transaction: transaction,
          );
          return league;
        } on DatabaseUniqueViolationException {
          // Invite code already taken: try another
          if (attempt >= 4) rethrow;
        }
      }
    });
    return detail(session, userId, league.id!);
  }

  Future<LeagueDetail> join(
    Session session,
    UuidValue userId,
    String inviteCode,
  ) async {
    final code = inviteCode.trim().toUpperCase();
    final league = await League.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(code),
    );
    if (league == null) {
      throw notFoundError('League with that code');
    }
    await pets.requireMine(session, userId);

    await session.db.transaction((transaction) async {
      final already = await LeagueMember.db.findFirstRow(
        session,
        where: (t) => t.leagueId.equals(league.id!) & t.userId.equals(userId),
        transaction: transaction,
      );
      if (already != null) return;
      final count = await LeagueMember.db.count(
        session,
        where: (t) => t.leagueId.equals(league.id!),
        transaction: transaction,
      );
      if (count >= maxLeagueMembers) {
        throw conflictError(
          'LEAGUE_FULL',
          'This league is full ($maxLeagueMembers members).',
        );
      }
      await LeagueMember.db.insertRow(
        session,
        LeagueMember(
          leagueId: league.id!,
          userId: userId,
          joinedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
    });
    return detail(session, userId, league.id!);
  }

  // Leaving forfeits any battles still going in that league. If the owner
  // leaves, the longest-standing member takes over; an empty league is deleted.
  Future<void> leave(Session session, UuidValue userId, int leagueId) async {
    await session.db.transaction((transaction) async {
      final member = await _requireMember(
        session,
        userId,
        leagueId,
        transaction,
      );
      final ongoing = await Duel.db.find(
        session,
        where: (t) =>
            t.leagueId.equals(leagueId) &
            t.status.equals(DuelStatus.ongoing) &
            (t.aUserId.equals(userId) | t.bUserId.equals(userId)),
        transaction: transaction,
      );
      for (final duel in ongoing) {
        final forfeited = duel.copyWith(
          status: DuelStatus.finished,
          endReason: 'Forfeit',
          finishedAt: DateTime.now().toUtc(),
        );
        forfeited.winnerUserId = duel.aUserId == userId
            ? duel.bUserId
            : duel.aUserId;
        await Duel.db.updateRow(session, forfeited, transaction: transaction);
      }
      await LeagueMember.db.deleteRow(
        session,
        member,
        transaction: transaction,
      );

      final remaining = await LeagueMember.db.find(
        session,
        where: (t) => t.leagueId.equals(leagueId),
        orderByList: (t) => [t.joinedAt.asc()],
        transaction: transaction,
      );
      final league = (await League.db.findById(
        session,
        leagueId,
        transaction: transaction,
      ))!;
      if (remaining.isEmpty) {
        await League.db.deleteRow(session, league, transaction: transaction);
      } else if (league.ownerId == userId) {
        await League.db.updateRow(
          session,
          league.copyWith(ownerId: remaining.first.userId),
          transaction: transaction,
        );
      }
    });
  }

  Future<List<LeagueSummary>> myLeagues(
    Session session,
    UuidValue userId,
  ) async {
    final memberships = await LeagueMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderByList: (t) => [t.joinedAt.asc()],
    );
    final now = DateTime.now().toUtc();
    final week = weekStart(now);
    return [
      for (final m in memberships)
        await () async {
          final league = (await League.db.findById(session, m.leagueId))!;
          await _settleFinishedSeasons(session, league, week);
          final standings = await _standings(session, league.id!, week, userId);
          final me = standings.where((s) => s.isYou).firstOrNull;
          final yourTurn = (await duels.forLeague(
            session,
            userId,
            league.id!,
          )).where((d) => d.yourTurn).length;
          return LeagueSummary(
            id: league.id!,
            name: league.name,
            memberCount: standings.length,
            myRank: me?.rank ?? standings.length,
            myScore: me?.totalScore ?? 0,
            seasonEndsAt: weekEnd(week),
            yourTurnCount: yourTurn,
          );
        }(),
    ];
  }

  Future<LeagueDetail> detail(
    Session session,
    UuidValue userId,
    int leagueId,
  ) async {
    await _requireMember(session, userId, leagueId, null);
    final league = (await League.db.findById(session, leagueId))!;
    final week = weekStart(DateTime.now().toUtc());
    await _settleFinishedSeasons(session, league, week);

    final lastWeek = week.subtract(const Duration(days: 7));
    final last = await SeasonResult.db.findFirstRow(
      session,
      where: (t) => t.leagueId.equals(leagueId) & t.weekStart.equals(lastWeek),
    );
    final lastWinner = last?.standings
        .where((s) => s.rank == 1 && last.winnerUserId != null)
        .firstOrNull;
    final myMemberIds = (await LeagueMember.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId) & t.userId.equals(userId),
    )).map((m) => m.id).toSet();

    return LeagueDetail(
      id: league.id!,
      name: league.name,
      inviteCode: league.inviteCode,
      isOwner: league.ownerId == userId,
      seasonStartsAt: week,
      seasonEndsAt: weekEnd(week),
      standings: await _standings(session, leagueId, week, userId),
      duels: await duels.forLeague(session, userId, leagueId),
      lastSeasonWinner: lastWinner?.petName,
      lastSeasonYourRank: last?.standings
          .where((s) => myMemberIds.contains(s.memberId))
          .firstOrNull
          ?.rank,
    );
  }

  Future<List<Trophy>> trophies(Session session, UuidValue userId) =>
      Trophy.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderByList: (t) => [t.weekStart.desc()],
      );

  // ── Seasons ───────────────────────────────────────────────────────────────

  Future<List<LeagueStanding>> _standings(
    Session session,
    int leagueId,
    DateTime week,
    UuidValue? callerId, {
    Transaction? transaction,
  }) async {
    final members = await LeagueMember.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      transaction: transaction,
    );
    if (members.isEmpty) return [];
    final userIds = members.map((m) => m.userId).toSet();
    final end = weekEnd(week);

    final petsByOwner = {
      for (final p in await Pet.db.find(
        session,
        where: (t) => t.ownerId.inSet(userIds),
        transaction: transaction,
      ))
        p.ownerId: p,
    };
    final meals = await Meal.db.find(
      session,
      where: (t) =>
          t.ownerId.inSet(userIds) &
          t.fed.equals(true) &
          (t.createdAt >= week) &
          (t.createdAt < end),
      transaction: transaction,
    );
    final wonDuels = await Duel.db.find(
      session,
      where: (t) =>
          t.leagueId.equals(leagueId) &
          t.weekStart.equals(week) &
          t.status.equals(DuelStatus.finished) &
          t.winnerUserId.notEquals(null),
      transaction: transaction,
    );

    return rankSeason([
      for (final m in members)
        if (petsByOwner[m.userId] case final pet?)
          SeasonActivity(
            memberId: m.id!,
            pet: pet,
            fedMeals: [
              for (final meal in meals)
                if (meal.ownerId == m.userId) meal,
            ],
            beatenFriendIds: [
              for (final d in wonDuels)
                if (d.winnerUserId == m.userId)
                  (d.aUserId == m.userId ? d.bUserId : d.aUserId).toString(),
            ],
            isCaller: m.userId == callerId,
          ),
    ]);
  }

  // Records the result of every finished season not yet settled, paying the
  // winner. Safe to call from several requests at once: a season that
  // another request settled first is skipped.
  Future<void> _settleFinishedSeasons(
    Session session,
    League league,
    DateTime currentWeek,
  ) async {
    final latest = await SeasonResult.db.findFirstRow(
      session,
      where: (t) => t.leagueId.equals(league.id!),
      orderByList: (t) => [t.weekStart.desc()],
    );
    var week = latest == null
        ? weekStart(league.createdAt)
        : latest.weekStart.add(const Duration(days: 7));
    final oldest = currentWeek.subtract(
      const Duration(days: 7 * _maxWeeksToSettle),
    );
    if (week.isBefore(oldest)) week = oldest;

    for (; week.isBefore(currentWeek); week = weekEnd(week)) {
      try {
        await session.db.transaction((transaction) async {
          final standings = await _standings(
            session,
            league.id!,
            week,
            null,
            transaction: transaction,
          );
          final top = standings.firstOrNull;
          final hasWinner =
              top != null &&
              standings.length >= minMembersForWinner &&
              top.totalScore > 0;
          final winnerMember = hasWinner
              ? await LeagueMember.db.findById(
                  session,
                  top.memberId,
                  transaction: transaction,
                )
              : null;

          await SeasonResult.db.insertRow(
            session,
            SeasonResult(
              leagueId: league.id!,
              weekStart: week,
              winnerUserId: winnerMember?.userId,
              standings: standings,
              createdAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
          if (winnerMember == null) return;

          final pet = await pets.findMine(
            session,
            winnerMember.userId,
            transaction: transaction,
          );
          if (pet != null) {
            await Pet.db.updateRow(
              session,
              pet.copyWith(coins: pet.coins + seasonWinnerCoins),
              transaction: transaction,
            );
          }
          await Trophy.db.insertRow(
            session,
            Trophy(
              userId: winnerMember.userId,
              leagueId: league.id!,
              leagueName: league.name,
              weekStart: week,
              score: top!.totalScore,
              createdAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
        });
      } on DatabaseUniqueViolationException {
        // Another request settled this season first
      }
    }
  }

  Future<LeagueMember> _requireMember(
    Session session,
    UuidValue userId,
    int leagueId,
    Transaction? transaction,
  ) async {
    final member = await LeagueMember.db.findFirstRow(
      session,
      where: (t) => t.leagueId.equals(leagueId) & t.userId.equals(userId),
      transaction: transaction,
    );
    if (member == null) throw notFoundError('League');
    return member;
  }

  String _newCode() => String.fromCharCodes([
    for (var i = 0; i < 6; i++)
      _codeAlphabet.codeUnitAt(_rng.nextInt(_codeAlphabet.length)),
  ]);
}

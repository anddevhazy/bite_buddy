import 'package:bite_buddy/features/battle/data/models/battle_move_mapper.dart';
import 'package:bite_buddy/features/league/domain/entities/league_entities.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

// Converts the generated server models into this feature's entities
class LeagueModels {
  static LeagueSummaryEntity summary(LeagueSummary s) => LeagueSummaryEntity(
    id: s.id,
    name: s.name,
    memberCount: s.memberCount,
    myRank: s.myRank,
    myScore: s.myScore,
    seasonEndsAt: s.seasonEndsAt.toLocal(),
    yourTurnCount: s.yourTurnCount,
  );

  static StandingEntity standing(LeagueStanding s) => StandingEntity(
    rank: s.rank,
    memberId: s.memberId,
    petName: s.petName,
    speciesKey: s.speciesKey,
    level: s.level,
    averageMealScore: s.averageMealScore,
    daysFed: s.daysFed,
    feedingScore: s.feedingScore,
    wins: s.wins,
    battleScore: s.battleScore,
    totalScore: s.totalScore,
    isYou: s.isYou,
  );

  static LeagueDetailEntity detail(LeagueDetail d) => LeagueDetailEntity(
    id: d.id,
    name: d.name,
    inviteCode: d.inviteCode,
    isOwner: d.isOwner,
    seasonStartsAt: d.seasonStartsAt.toLocal(),
    seasonEndsAt: d.seasonEndsAt.toLocal(),
    standings: d.standings.map(standing).toList(),
    challenge: LeagueChallengeEntity(
      title: d.challenge.title,
      description: d.challenge.description,
      progress: d.challenge.progress,
      target: d.challenge.target,
      completed: d.challenge.completed,
      rewardCoins: d.challenge.rewardCoins,
    ),
    duels: d.duels.map(duel).toList(),
    lastSeasonWinner: d.lastSeasonWinner,
    lastSeasonYourRank: d.lastSeasonYourRank,
    lastChallengeCompleted: d.lastChallengeCompleted,
  );

  static DuelEntity duel(DuelView d) {
    final r = d.lastRound;
    return DuelEntity(
      id: d.id,
      leagueId: d.leagueId,
      myPetName: d.myPetName,
      mySpeciesKey: d.mySpeciesKey,
      theirPetName: d.theirPetName,
      theirSpeciesKey: d.theirSpeciesKey,
      myHp: d.myHp,
      myMaxHp: d.myMaxHp,
      theirHp: d.theirHp,
      theirMaxHp: d.theirMaxHp,
      myAttack: d.myAttack,
      myDefense: d.myDefense,
      theirAttack: d.theirAttack,
      theirDefense: d.theirDefense,
      mySpecialCooldown: d.mySpecialCooldown,
      round: d.round,
      roundDeadline: d.roundDeadline.toLocal(),
      yourTurn: d.yourTurn,
      theyHaveMoved: d.theyHaveMoved,
      youMissed: d.youMissed,
      theirRecentMoves: [
        for (final m in d.theirRecentMoves)
          m == null ? null : BattleMoveMapper.toApp(m),
      ],
      lastRound: r == null
          ? null
          : DuelRoundEntity(
              round: r.round,
              myMove: r.myMove == null
                  ? null
                  : BattleMoveMapper.toApp(r.myMove!),
              theirMove: r.theirMove == null
                  ? null
                  : BattleMoveMapper.toApp(r.theirMove!),
              damageDealt: r.damageDealt,
              damageTaken: r.damageTaken,
              myCritical: r.myCritical,
              theirCritical: r.theirCritical,
              clash: r.clash,
              message: r.message,
            ),
      result: d.result == null ? null : DuelResult.values.byName(d.result!),
      endReason: d.endReason,
    );
  }

  static TrophyEntity trophy(Trophy t) => TrophyEntity(
    leagueName: t.leagueName,
    weekStart: t.weekStart.toLocal(),
    score: t.score,
  );
}

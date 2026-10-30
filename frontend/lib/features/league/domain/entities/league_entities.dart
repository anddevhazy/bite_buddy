import 'package:bite_buddy/features/global/enums/battle_move.dart';
import 'package:equatable/equatable.dart';

// A league in your list of leagues
class LeagueSummaryEntity extends Equatable {
  final int id;
  final String name;
  final int memberCount;
  final int myRank;
  final int myScore;
  final DateTime seasonEndsAt;
  // Friend battles waiting for your move
  final int yourTurnCount;

  const LeagueSummaryEntity({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.myRank,
    required this.myScore,
    required this.seasonEndsAt,
    required this.yourTurnCount,
  });

  @override
  List<Object?> get props => [id, myRank, myScore, yourTurnCount, memberCount];
}

// One member's row in the season table. Scores are 0-100; the total is 70%
// feeding and 30% battles.
class StandingEntity extends Equatable {
  final int rank;
  final int memberId;
  final String petName;
  final String speciesKey;
  final int level;
  final int averageMealScore;
  final int daysFed;
  final int feedingScore;
  final int wins;
  final int battleScore;
  final int totalScore;
  final bool isYou;

  const StandingEntity({
    required this.rank,
    required this.memberId,
    required this.petName,
    required this.speciesKey,
    required this.level,
    required this.averageMealScore,
    required this.daysFed,
    required this.feedingScore,
    required this.wins,
    required this.battleScore,
    required this.totalScore,
    required this.isYou,
  });

  @override
  List<Object?> get props => [memberId, rank, totalScore];
}

// This week's team goal. When it's met by the end of the season, every
// member gets [rewardCoins].
class LeagueChallengeEntity extends Equatable {
  final String title;
  final String description;
  final int progress;
  final int target;
  final bool completed;
  final int rewardCoins;

  const LeagueChallengeEntity({
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.completed,
    required this.rewardCoins,
  });

  @override
  List<Object?> get props => [title, progress, target, completed];
}

class LeagueDetailEntity extends Equatable {
  final int id;
  final String name;
  final String inviteCode;
  final bool isOwner;
  final DateTime seasonStartsAt;
  final DateTime seasonEndsAt;
  final List<StandingEntity> standings;
  final LeagueChallengeEntity challenge;
  final List<DuelEntity> duels;
  final String? lastSeasonWinner;
  final int? lastSeasonYourRank;
  // Whether last week's team challenge was met and paid out
  final bool? lastChallengeCompleted;

  const LeagueDetailEntity({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.isOwner,
    required this.seasonStartsAt,
    required this.seasonEndsAt,
    required this.standings,
    required this.challenge,
    required this.duels,
    this.lastSeasonWinner,
    this.lastSeasonYourRank,
    this.lastChallengeCompleted,
  });

  @override
  List<Object?> get props => [
    id,
    standings,
    challenge,
    duels,
    lastSeasonWinner,
  ];
}

enum DuelResult { won, lost, draw }

class DuelRoundEntity extends Equatable {
  final int round;
  // Null when that player missed the deadline
  final BattleMove? myMove;
  final BattleMove? theirMove;
  final int damageDealt;
  final int damageTaken;
  final bool myCritical;
  final bool theirCritical;
  final String clash;
  final String message;

  const DuelRoundEntity({
    required this.round,
    required this.myMove,
    required this.theirMove,
    required this.damageDealt,
    required this.damageTaken,
    required this.myCritical,
    required this.theirCritical,
    required this.clash,
    required this.message,
  });

  @override
  List<Object?> get props => [round];
}

// A friend battle from your side: "my" buddy against "their" buddy
class DuelEntity extends Equatable {
  final int id;
  final int leagueId;
  final String myPetName;
  final String mySpeciesKey;
  final String theirPetName;
  final String theirSpeciesKey;
  final int myHp;
  final int myMaxHp;
  final int theirHp;
  final int theirMaxHp;
  final int myAttack;
  final int myDefense;
  final int theirAttack;
  final int theirDefense;
  final int mySpecialCooldown;
  final int round;
  final DateTime roundDeadline;
  // You still have to pick a move this round
  final bool yourTurn;
  // Your friend has already picked theirs
  final bool theyHaveMoved;
  // Rounds you've missed in a row (two forfeits the battle)
  final int youMissed;
  // Their last few moves, oldest first (null = missed)
  final List<BattleMove?> theirRecentMoves;
  final DuelRoundEntity? lastRound;
  // Null while the battle is still going
  final DuelResult? result;
  final String? endReason;

  const DuelEntity({
    required this.id,
    required this.leagueId,
    required this.myPetName,
    required this.mySpeciesKey,
    required this.theirPetName,
    required this.theirSpeciesKey,
    required this.myHp,
    required this.myMaxHp,
    required this.theirHp,
    required this.theirMaxHp,
    required this.myAttack,
    required this.myDefense,
    required this.theirAttack,
    required this.theirDefense,
    required this.mySpecialCooldown,
    required this.round,
    required this.roundDeadline,
    required this.yourTurn,
    required this.theyHaveMoved,
    required this.youMissed,
    required this.theirRecentMoves,
    this.lastRound,
    this.result,
    this.endReason,
  });

  bool get isOver => result != null;

  @override
  List<Object?> get props => [
    id,
    round,
    yourTurn,
    theyHaveMoved,
    myHp,
    theirHp,
    result,
  ];
}

// A season win, shown on your profile
class TrophyEntity extends Equatable {
  final String leagueName;
  final DateTime weekStart;
  final int score;

  const TrophyEntity({
    required this.leagueName,
    required this.weekStart,
    required this.score,
  });

  @override
  List<Object?> get props => [leagueName, weekStart];
}

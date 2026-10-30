import 'package:equatable/equatable.dart';

enum GuideTopicId {
  basics,
  health,
  energy,
  nutrition,
  levels,
  streak,
  coins,
  scanning,
  grades,
  battles,
  battleMoves,
  leagues,
  friendBattles,
  leaderboard,
  weeklySummary,
  mealIdeas,
  sharedStreaks,
  teamChallenges,
  activity,
  homeWidget,
  ownPet,
  memoryBook,
  keepsakes,
}

// One section of the "How to play" guide
class GuideTopic extends Equatable {
  final GuideTopicId id;
  final String emoji;
  final String title;
  // One short sentence, shown under the title
  final String summary;
  // The details, one point per entry
  final List<String> points;

  const GuideTopic({
    required this.id,
    required this.emoji,
    required this.title,
    required this.summary,
    required this.points,
  });

  @override
  List<Object?> get props => [id];
}

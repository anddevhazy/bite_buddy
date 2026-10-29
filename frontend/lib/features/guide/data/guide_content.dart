import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';

// The text of the "How to play" guide. The numbers here mirror the game rules
// on the server (backend/bite_buddy_server/lib/src/utils/pet_stats.dart,
// services/meal_service.dart and services/battle_service.dart); update both
// together when the rules change.
class GuideContent {
  static const List<GuideTopic> topics = [
    GuideTopic(
      id: GuideTopicId.basics,
      emoji: '🍱',
      title: 'How Bite Buddy works',
      summary: 'Your buddy eats what you eat, so eat well!',
      points: [
        'Every time you have a meal, snap it with the Food Scanner.',
        'The AI Chef works out its nutrition and gives it a health score.',
        'Feed the meal to your buddy: healthy food makes it healthier, '
            'stronger and happier. Junk food does the opposite.',
        'Battle other pets to earn coins and XP, and climb the nutrition '
            'leaderboard by eating well every day.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.health,
      emoji: '❤️',
      title: 'Health',
      summary: "How well your buddy is doing, from 0 to 100.",
      points: [
        'It starts at 100.',
        'Each meal changes it by up to 10: a meal scoring 100 adds 10, a meal '
            'scoring 50 changes nothing, and a meal scoring 0 takes 10 away.',
        "If your buddy goes 8 hours without eating, it loses 2 health every "
            'hour until you feed it.',
        'In battles, health sets how many hit points your buddy has and how '
            'well it defends.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.energy,
      emoji: '⚡',
      title: 'Energy',
      summary: 'Fuel for battles, from 0 to 100.',
      points: [
        'It starts at 50.',
        'Every meal adds 5 to 15 energy. Healthier meals add more; eating '
            'more food does not.',
        'You need at least 10 energy to start a battle.',
        'Winning a battle gives 8 energy; losing costs 10.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.nutrition,
      emoji: '🍽️',
      title: 'Nutrition',
      summary: 'How well you have been eating lately, from 0 to 100.',
      points: [
        'Your first meal sets it to that meal\'s health score.',
        'After that, each meal moves it 30% of the way toward the new '
            "meal's score, so one bad meal only dents it, but a habit "
            'shows.',
        'It drops 1 point every hour once your buddy has gone 8 hours without '
            'food.',
        'It decides your place on the leaderboard and makes your buddy hit '
            'harder in battles.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.levels,
      emoji: '⭐',
      title: 'Level and XP',
      summary: 'XP (experience points) levels your buddy up.',
      points: [
        'Level 1 needs 100 XP to reach level 2, level 2 needs 200, and so on.',
        'Every meal gives 10 XP, plus 5 more if it scores 70 or higher.',
        'If your buddy is already at full health, any healing a meal would '
            'have given turns into bonus XP instead.',
        'Winning a battle gives 20 XP plus 5 for each level of the opponent. '
            'Losing still gives 5 XP.',
        'Higher levels make your buddy stronger in battles.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.streak,
      emoji: '🔥',
      title: 'Daily streak',
      summary: 'Feed your buddy every day to build a streak.',
      points: [
        'Feeding your buddy on a new day adds 1 to your streak.',
        'Miss a whole day and the streak goes back to 0.',
        "The first meal of each day earns bonus XP equal to your streak, up to "
            '+10 XP a day.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.coins,
      emoji: '🪙',
      title: 'Coins',
      summary: 'Your reward for winning battles.',
      points: [
        'Each opponent pays a set number of coins when you beat it, shown on '
            'its card in the Battle Arena. Tougher opponents pay more.',
        'Losing a battle pays nothing.',
        "There's nothing to spend coins on yet. A shop is on the way, so "
            'keep saving!',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.scanning,
      emoji: '📸',
      title: 'Scanning meals',
      summary: 'Only real meals, photographed right before you eat them.',
      points: [
        'Take the photo with the in-app camera. Get the whole plate in the '
            'shot, in good light.',
        'Screenshots, photos of a screen, downloaded or stock pictures and '
            'drawings are rejected, and the reason is shown.',
        "The same photo can't be scanned twice.",
        'Feed a scanned meal within 3 hours, or it expires.',
        'Your buddy can eat up to 8 meals in any 24 hours.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.grades,
      emoji: '🅰️',
      title: 'Health score and grades',
      summary: 'How good a meal is for you, from 0 to 100.',
      points: [
        'The AI Chef scores each meal: balanced meals with whole foods and '
            'vegetables score higher; fried, sugary or heavily processed food '
            'scores lower.',
        'The grade comes from the score: A is 85 and up, B is 70 and up, C is '
            '55 and up, D is 40 and up, and F is below 40.',
        'Protein, carbs, fats, vitamins, minerals and fiber show how much of '
            "an adult's daily target the meal covers.",
      ],
    ),
    GuideTopic(
      id: GuideTopicId.battles,
      emoji: '⚔️',
      title: 'Battles',
      summary: 'Fight opponents to earn coins, XP and energy.',
      points: [
        'Pick an opponent in the Battle Arena. The win % on its card is an '
            "estimate of your chances based on both fighters' stats.",
        "Your buddy's strength comes from its level, health and nutrition, so "
            'eating well makes it a better fighter.',
        'A battle ends when one side runs out of HP. If it lasts 30 rounds, '
            'whoever has more HP left wins.',
        'You fight one battle at a time. Starting a new one while another is '
            'unfinished counts the old one as a loss.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.battleMoves,
      emoji: '🎯',
      title: 'Battle moves',
      summary:
          'Each round, you and your opponent choose a move at the same time.',
      points: [
        'Attack: a normal hit.',
        'Special: hits 60% harder, then needs 3 rounds to recharge.',
        "Defend: you don't attack, but you take half damage and recover a "
            'little HP.',
        'Your opponent plays the same way: it saves its special for the right '
            'moment and defends when it is low on HP.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.leaderboard,
      emoji: '🏆',
      title: 'Leaderboard',
      summary: 'The top buddies, ranked by nutrition.',
      points: [
        'Buddies are ranked by their nutrition score; ties go to the higher '
            'level.',
        'Only buddies that have eaten at least one meal are listed.',
        'Your buddy is marked "You" with a gold border.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.weeklySummary,
      emoji: '📊',
      title: 'Weekly summary',
      summary: 'A look at what you fed your buddy over the last 7 days.',
      points: [
        'It counts the meals you fed and on how many days you ate.',
        "The daily averages show how much of an adult's daily target you got "
            'on the days you ate.',
        'The tips point out what is most worth improving, like a nutrient you '
            'are low on.',
      ],
    ),
  ];

  static GuideTopic byId(GuideTopicId id) =>
      topics.firstWhere((t) => t.id == id);
}

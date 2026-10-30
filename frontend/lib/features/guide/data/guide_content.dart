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
        'Win a week in a friend league for 500 coins.',
        'Meet your league\'s weekly team challenge for 150 coins each.',
        'Every day a shared streak grows, you and your friend get 5 coins.',
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
        "A photo can't be scanned twice, and neither can a new photo of a "
            'plate you scanned in the last 3 hours.',
        'Scanning saves the meal; it only counts once you tap Feed. Check '
            'the results, then feed it straight away, or later from your '
            'meal log (Collection, Meals tab).',
        'A scanned meal must be fed within 3 hours, or it expires.',
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
      title: 'Arena fights',
      summary: 'Real-time fights against computer opponents.',
      points: [
        'Your buddy fights with HP, ATK (attack) and DEF (defence), shown at '
            'the top of the Battle Arena. They grow with its level, health and '
            'nutrition, so eating well makes it a better fighter.',
        'Watch the opponent wind up. A red glow is a jab: hold Block. Block '
            'just before it lands for a perfect block, which takes no damage '
            'and stuns them.',
        "A purple glow is a heavy attack. It can't be blocked: Dodge it, and "
            "they're stunned.",
        'Some opponents follow a jab with a quick second one. Dodge needs a '
            'moment to recharge, so Block is the safe answer to jabs.',
        "Tougher opponents fake windups to bait you. Don't move too early!",
        'When the opponent shows OPEN!, Attack: counters hit harder. Dodges, '
            'perfect blocks and counters fill your Special meter; when it\'s '
            'full, Special lands a huge hit.',
        'Each opponent card shows how long you have to react, how often it '
            'fakes and how often it throws heavy attacks.',
        'Winning pays coins, XP and energy; losing or giving up costs energy.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.battleMoves,
      emoji: '🎯',
      title: 'Friend battle moves',
      summary: 'In friend battles, each move beats one other.',
      points: [
        'Attack beats Special: you strike first and the special fizzles.',
        'Special beats Defend: it smashes through the guard for big damage. '
            'After using it, Special needs 2 rounds to recharge.',
        'Defend beats Attack: you block most of the hit and counter.',
        'When you both pick the same move, you trade hits; if you both '
            'defend, you each recover a little HP.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.leagues,
      emoji: '🏆',
      title: 'Friend leagues',
      summary: 'Compete with friends in weekly seasons.',
      points: [
        'Create a league and share its invite code, or join a friend\'s '
            '(Battle tab, then Friends). Up to 20 people per league, and you '
            'can be in several.',
        'Seasons run Monday to Sunday (they start at midnight UTC, which is '
            '1am in Nigeria). A new one starts automatically.',
        'Your season score is 70% feeding and 30% friend battles.',
        'Feeding: your average meal health score, scaled by how many of the 7 '
            'days you fed your buddy. Eating well every day beats eating a '
            'lot on one day.',
        'Battles: 20 points per win against a league friend, up to 100. Only '
            '2 wins against the same friend count each season.',
        'The weekly winner gets 500 coins and a trophy on their profile. '
            'Ties go to the better feeding score.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.friendBattles,
      emoji: '🤺',
      title: 'Friend battles',
      summary: 'Turn-based battles you play in your own time.',
      points: [
        'Challenge anyone in your league from the season table.',
        'Each round, you both pick a move in secret. It plays out once both '
            'moves are in, using the usual rules: Attack beats Special, '
            'Special beats Defend, Defend beats Attack.',
        'There are no tells against a friend. Watch their last few moves '
            'instead and guess what they\'ll do next.',
        'You have 24 hours to make each move. Miss one and your buddy does '
            'nothing that round; miss two in a row and you forfeit.',
        "Friend battles don't cost energy or pay coins: they count toward "
            'your league season score.',
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
        'It includes every player, and only buddies that have eaten at '
            'least one meal are listed.',
        'It shows the top 50. If your buddy ranks lower, your own rank is '
            'shown at the bottom.',
        'Scores drop for buddies that go hungry, even if their owner stops '
            'opening the app, so you have to keep eating well to stay on top.',
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
    GuideTopic(
      id: GuideTopicId.mealIdeas,
      emoji: '🥗',
      title: 'Meal ideas',
      summary: 'Meals that fill the gaps in your week.',
      points: [
        'Tap "Meal ideas" on the weekly summary to get 3 ideas for today.',
        'They aim at whatever you were low on this week, like protein or '
            'fiber, and lean toward food from your country and dishes you '
            'already eat.',
        'You get a new set each day. If the AI is busy, you get simpler '
            'ideas instead; try again later for fresh ones.',
        "They're ideas, not medical advice. Eat what works for you.",
      ],
    ),
    GuideTopic(
      id: GuideTopicId.sharedStreaks,
      emoji: '🤝',
      title: 'Shared streaks',
      summary: 'A streak you keep alive with a friend.',
      points: [
        'Invite a friend from one of your leagues from the Shared streaks '
            'card on My Pet. It starts once they accept.',
        'A day only counts when you both feed your buddies. If one of you '
            'misses a whole day, the shared streak goes back to 0.',
        'Each day it grows, you both get 5 coins.',
        'The card shows whether each of you has fed today, so you can nudge '
            'your friend.',
        'You can have up to 5 shared streaks, and end one at any time.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.teamChallenges,
      emoji: '🎯',
      title: 'Team challenges',
      summary: 'A weekly goal the whole league works on together.',
      points: [
        'Each league gets a new challenge every Monday, like feeding a number '
            'of good meals or finishing friend battles between you.',
        'Everyone\'s meals and battles count toward it. The bigger the '
            'league, the bigger the target.',
        'If the league meets it by the end of the season, every member gets '
            '150 coins, on top of the prize for winning the week.',
        'Leagues need at least 2 members for the reward.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.activity,
      emoji: '👟',
      title: 'Steps and sleep',
      summary: 'Moving and sleeping well boost your buddy.',
      points: [
        'Connect Health Connect (Android) or Apple Health (iPhone) from the '
            'Steps and sleep card on My Pet. Bite Buddy only reads your steps '
            'and sleep.',
        'Every 1,000 steps today gives your buddy 1 energy, up to 10 a day.',
        'Sleeping 7 hours or more gives your buddy 5 health, once a day.',
        'Your numbers update whenever you open My Pet or pull to refresh.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.homeWidget,
      emoji: '📱',
      title: 'Home-screen widget',
      summary: 'See how your buddy is doing without opening the app.',
      points: [
        'Long-press your home screen, tap Widgets, find Bite Buddy and drag it '
            'onto the screen.',
        'It shows your buddy, its mood and your streak. Your buddy gets '
            'hungry 8 hours after its last meal, and the widget shows that '
            'too.',
        'It updates whenever you open the app.',
      ],
    ),
    GuideTopic(
      id: GuideTopicId.ownPet,
      emoji: '📸',
      title: 'Use my own pet',
      summary: 'Turn a photo of your real pet into your buddy.',
      points: [
        'Tap "Use my own pet" on My Pet, then take or choose a photo.',
        'Use a clear photo of just your pet. Photos with people in them are '
            'refused, and so is anything that isn\'t a real animal.',
        'Your buddy then shows your pet\'s picture everywhere: My Pet, '
            'battles, leagues, shared streaks and the home-screen widget. '
            'Friends see it too.',
        'It only changes the look. Your buddy keeps its stats, level and '
            'species powers.',
        'You can make up to 3 pictures a day, and go back to the original '
            'buddy picture at any time.',
      ],
    ),
  ];

  static GuideTopic byId(GuideTopicId id) =>
      topics.firstWhere((t) => t.id == id);
}

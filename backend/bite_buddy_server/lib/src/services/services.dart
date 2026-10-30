import 'activity_service.dart';
import 'battle_service.dart';
import 'duel_service.dart';
import 'leaderboard_service.dart';
import 'memory_service.dart';
import 'league_service.dart';
import 'meal_service.dart';
import 'nutrition_ai_service.dart';
import 'pet_service.dart';
import 'portrait_service.dart';
import 'streak_service.dart';

// One shared instance of each service, used by the endpoints
const petService = PetService();
const memoryService = MemoryService(pets: petService);
const leaderboardService = LeaderboardService();
final nutritionAiService = NutritionAiService();
const streakService = StreakService(pets: petService);
const activityService = ActivityService(pets: petService);
final mealService = MealService(
  ai: nutritionAiService,
  pets: petService,
  streaks: streakService,
  memories: memoryService,
);
final battleService = BattleService(pets: petService, memories: memoryService);
final duelService = DuelService(pets: petService);
final leagueService = LeagueService(pets: petService, duels: duelService);
final portraitService = PortraitService(
  ai: nutritionAiService,
  pets: petService,
);

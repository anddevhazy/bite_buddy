import 'battle_service.dart';
import 'duel_service.dart';
import 'leaderboard_service.dart';
import 'league_service.dart';
import 'meal_service.dart';
import 'nutrition_ai_service.dart';
import 'pet_service.dart';

// One shared instance of each service, used by the endpoints
const petService = PetService();
const leaderboardService = LeaderboardService();
final nutritionAiService = NutritionAiService();
final mealService = MealService(ai: nutritionAiService, pets: petService);
final battleService = BattleService(pets: petService);
final duelService = DuelService(pets: petService);
final leagueService = LeagueService(pets: petService, duels: duelService);

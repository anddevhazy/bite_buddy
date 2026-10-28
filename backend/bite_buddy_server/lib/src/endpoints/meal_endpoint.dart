import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/services.dart';
import '../utils/session_user.dart';

// client.meal
class MealEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Throws BiteBuddyException(MEAL_REJECTED) for anything that isn't a live
  // photo of food
  Future<Meal> analyze(Session session, ByteData image) =>
      mealService.analyze(session, session.userId, image);

  // utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes on the phone
  Future<FeedResult> feed(
    Session session,
    int mealId,
    int utcOffsetMinutes,
  ) => mealService.feed(session, session.userId, mealId, utcOffsetMinutes);

  Future<List<Meal>> history(Session session) =>
      mealService.history(session, session.userId);

  // The last 7 days of meals, summarised, with tips
  Future<NutritionInsights> insights(Session session) =>
      mealService.insights(session, session.userId);
}

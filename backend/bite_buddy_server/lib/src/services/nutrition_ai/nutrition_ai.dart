import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

// What the AI read from a meal photo
class NutritionAnalysis {
  final bool isFood;
  final bool isLivePhoto;
  final String rejectionReason;
  final String name;
  final String description;
  final int calories;
  final int proteinPct;
  final int carbsPct;
  final int fatsPct;
  final int vitaminsPct;
  final int mineralsPct;
  final int fiberPct;
  final int healthScore;

  const NutritionAnalysis({
    required this.isFood,
    required this.isLivePhoto,
    required this.rejectionReason,
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
  });

  factory NutritionAnalysis.fromJson(Map<String, dynamic> json) {
    int pct(String key) => (json[key] as num).round().clamp(0, 200);
    return NutritionAnalysis(
      isFood: json['isFood'] as bool,
      isLivePhoto: json['isLivePhoto'] as bool,
      rejectionReason: json['rejectionReason'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      calories: (json['calories'] as num).round().clamp(0, 5000),
      proteinPct: pct('proteinPct'),
      carbsPct: pct('carbsPct'),
      fatsPct: pct('fatsPct'),
      vitaminsPct: pct('vitaminsPct'),
      mineralsPct: pct('mineralsPct'),
      fiberPct: pct('fiberPct'),
      healthScore: (json['healthScore'] as num).round().clamp(0, 100),
    );
  }
}

// One AI provider (Gemini, Claude, ...) that can read a meal photo
abstract class NutritionAiProvider {
  Future<NutritionAnalysis> analyze(Session session, Uint8List jpeg);
}

// Every provider gets the same instructions and returns the same fields, so
// switching providers doesn't change how meals are judged.
const nutritionSystemPrompt = '''
You are the food scanner in Bite Buddy, a game where people feed a virtual pet with photos of the meals they are about to eat. A healthy pet depends on honest scans, so you do two jobs.

1. Decide whether the photo is a real meal photographed just now with a phone camera. Set isFood to false if there is no food or drink in the picture. Set isLivePhoto to false if the picture looks like it came from somewhere else: a screenshot, a photo of a screen or monitor (moire patterns, pixel grids, screen glare or bezels), a printed picture or menu, a stock or restaurant marketing photo (studio lighting, watermarks, text overlays, perfect styling), an illustration or an AI-generated image. Ordinary home or canteen photos with messy plates, odd angles and imperfect lighting are what live photos look like, so give those the benefit of the doubt. When you reject a photo, explain why in rejectionReason in one short friendly sentence; otherwise leave it empty.

2. If the photo is a live meal, estimate its nutrition for the portion shown. name is a short dish name (e.g. "Red Beans and Rice"); description is one sentence about what you see. calories is the estimated total kcal. proteinPct, carbsPct, fatsPct, vitaminsPct, mineralsPct and fiberPct are how much of an average adult's daily target this portion covers, as whole-number percentages. healthScore (0-100) rates how good the meal is for you: balance of macronutrients, whole foods and vegetables score higher; heavily processed, fried, or sugary food scores lower. Judge typical home cooking from any cuisine fairly.

If you reject the photo, still fill every field, using an empty string or 0.''';

const nutritionUserPrompt = 'Scan this meal.';

// Field name -> JSON type. Each provider turns this into its own schema format.
const nutritionFields = <String, String>{
  'isFood': 'boolean',
  'isLivePhoto': 'boolean',
  'rejectionReason': 'string',
  'name': 'string',
  'description': 'string',
  'calories': 'integer',
  'proteinPct': 'integer',
  'carbsPct': 'integer',
  'fatsPct': 'integer',
  'vitaminsPct': 'integer',
  'mineralsPct': 'integer',
  'fiberPct': 'integer',
  'healthScore': 'integer',
};

BiteBuddyException scannerUnavailable() => BiteBuddyException(
  code: 'AI_UNAVAILABLE',
  message: 'The food scanner is busy right now. Please try again.',
);

BiteBuddyException photoDeclined() => BiteBuddyException(
  code: 'MEAL_REJECTED',
  message: "We couldn't scan this photo. Try another picture of your meal.",
);

String requirePassword(Session session, String key) {
  final value = session.passwords[key];
  if (value == null || value.isEmpty) {
    session.log(
      '$key is missing from config/passwords.yaml',
      level: LogLevel.error,
    );
    throw scannerUnavailable();
  }
  return value;
}

// POSTs JSON, retrying once on network errors, rate limits (429) and server
// errors. Anything else that isn't a 200 becomes AI_UNAVAILABLE.
Future<http.Response> postWithRetry(
  Session session,
  http.Client client, {
  required String providerName,
  required Uri url,
  required Map<String, String> headers,
  required String body,
}) async {
  for (var attempt = 1; ; attempt++) {
    final http.Response response;
    try {
      response = await client
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 120));
    } on Exception catch (e) {
      session.log('$providerName request failed: $e', level: LogLevel.error);
      if (attempt < 2) continue;
      throw scannerUnavailable();
    }

    if (response.statusCode == 200) return response;

    final retryable = response.statusCode == 429 || response.statusCode >= 500;
    session.log(
      '$providerName returned ${response.statusCode}: ${response.body}',
      level: retryable ? LogLevel.warning : LogLevel.error,
    );
    if (retryable && attempt < 2) {
      await Future.delayed(const Duration(seconds: 2));
      continue;
    }
    throw scannerUnavailable();
  }
}

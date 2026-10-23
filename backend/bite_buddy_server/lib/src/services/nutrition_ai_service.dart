import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

// What Claude read from a meal photo
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

// Sends a meal photo to Claude and gets nutrition back as JSON that matches
// _schema. Dart has no official Anthropic SDK, so this calls the Messages API
// over HTTP. The API key is read from config/passwords.yaml (anthropicApiKey).
class NutritionAiService {
  static const _model = 'claude-opus-5-5';
  static final _endpoint = Uri.parse('https://api.anthropic.com/v1/messages');

  final http.Client _http;

  NutritionAiService({http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  static const _systemPrompt = '''
You are the food scanner in Bite Buddy, a game where people feed a virtual pet with photos of the meals they are about to eat. A healthy pet depends on honest scans, so you do two jobs.

1. Decide whether the photo is a real meal photographed just now with a phone camera. Set isFood to false if there is no food or drink in the picture. Set isLivePhoto to false if the picture looks like it came from somewhere else: a screenshot, a photo of a screen or monitor (moire patterns, pixel grids, screen glare or bezels), a printed picture or menu, a stock or restaurant marketing photo (studio lighting, watermarks, text overlays, perfect styling), an illustration or an AI-generated image. Ordinary home or canteen photos with messy plates, odd angles and imperfect lighting are what live photos look like, so give those the benefit of the doubt. When you reject a photo, explain why in rejectionReason in one short friendly sentence; otherwise leave it empty.

2. If the photo is a live meal, estimate its nutrition for the portion shown. name is a short dish name (e.g. "Red Beans and Rice"); description is one sentence about what you see. calories is the estimated total kcal. proteinPct, carbsPct, fatsPct, vitaminsPct, mineralsPct and fiberPct are how much of an average adult's daily target this portion covers, as whole-number percentages. healthScore (0-100) rates how good the meal is for you: balance of macronutrients, whole foods and vegetables score higher; heavily processed, fried, or sugary food scores lower. Judge typical home cooking from any cuisine fairly.

If you reject the photo, still fill every field, using an empty string or 0.''';

  static const Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'isFood': {'type': 'boolean'},
      'isLivePhoto': {'type': 'boolean'},
      'rejectionReason': {'type': 'string'},
      'name': {'type': 'string'},
      'description': {'type': 'string'},
      'calories': {'type': 'integer'},
      'proteinPct': {'type': 'integer'},
      'carbsPct': {'type': 'integer'},
      'fatsPct': {'type': 'integer'},
      'vitaminsPct': {'type': 'integer'},
      'mineralsPct': {'type': 'integer'},
      'fiberPct': {'type': 'integer'},
      'healthScore': {'type': 'integer'},
    },
    'required': [
      'isFood',
      'isLivePhoto',
      'rejectionReason',
      'name',
      'description',
      'calories',
      'proteinPct',
      'carbsPct',
      'fatsPct',
      'vitaminsPct',
      'mineralsPct',
      'fiberPct',
      'healthScore',
    ],
    'additionalProperties': false,
  };

  Future<NutritionAnalysis> analyze(Session session, Uint8List jpeg) async {
    final apiKey = session.passwords['anthropicApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      session.log(
        'anthropicApiKey is missing from config/passwords.yaml',
        level: LogLevel.error,
      );
      throw _unavailable();
    }

    final body = jsonEncode({
      'model': _model,
      'max_tokens': 16000,
      // If a safety classifier declines the request, the API retries it on
      // the recommended fallback model instead of returning a refusal
      'fallbacks': 'default',
      'output_config': {
        'effort': 'medium',
        'format': {'type': 'json_schema', 'schema': _schema},
      },
      'system': _systemPrompt,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'image',
              'source': {
                'type': 'base64',
                'media_type': 'image/jpeg',
                'data': base64Encode(jpeg),
              },
            },
            {'type': 'text', 'text': 'Scan this meal.'},
          ],
        },
      ],
    });

    final response = await _send(session, apiKey, body);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final stopReason = json['stop_reason'];
    if (stopReason == 'refusal') {
      throw BiteBuddyException(
        code: 'MEAL_REJECTED',
        message: "We couldn't scan this photo. Try another picture of your meal.",
      );
    }
    if (stopReason == 'max_tokens') {
      session.log('Food scan hit max_tokens', level: LogLevel.warning);
      throw _unavailable();
    }

    // Thinking blocks come first; the JSON is in the text block
    final content = (json['content'] as List).cast<Map<String, dynamic>>();
    final text = content.firstWhere(
      (b) => b['type'] == 'text',
      orElse: () => throw _unavailable(),
    )['text'] as String;

    return NutritionAnalysis.fromJson(jsonDecode(text) as Map<String, dynamic>);
  }

  // One retry for rate limits, overload and server errors
  Future<http.Response> _send(
    Session session,
    String apiKey,
    String body,
  ) async {
    for (var attempt = 1; ; attempt++) {
      final http.Response response;
      try {
        response = await _http
            .post(
              _endpoint,
              headers: {
                'content-type': 'application/json',
                'x-api-key': apiKey,
                'anthropic-version': '2026-10-21',
                'anthropic-beta': 'server-side-fallback-2026-07-01',
              },
              body: body,
            )
            .timeout(const Duration(seconds: 120));
      } on Exception catch (e) {
        session.log('Food scan request failed: $e', level: LogLevel.error);
        if (attempt < 2) continue;
        throw _unavailable();
      }

      if (response.statusCode == 200) return response;

      final retryable =
          response.statusCode == 429 || response.statusCode >= 500;
      session.log(
        'Claude API returned ${response.statusCode}: ${response.body}',
        level: retryable ? LogLevel.warning : LogLevel.error,
      );
      if (retryable && attempt < 2) {
        await Future.delayed(const Duration(seconds: 2));
        continue;
      }
      throw _unavailable();
    }
  }

  BiteBuddyException _unavailable() => BiteBuddyException(
    code: 'AI_UNAVAILABLE',
    message: 'The food scanner is busy right now. Please try again.',
  );
}

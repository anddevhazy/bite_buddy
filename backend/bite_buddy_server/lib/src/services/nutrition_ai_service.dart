import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import 'nutrition_ai/claude_nutrition_ai.dart';
import 'nutrition_ai/gemini_nutrition_ai.dart';
import 'nutrition_ai/nutrition_ai.dart';

export 'nutrition_ai/nutrition_ai.dart' show NutritionAnalysis;

// Reads meal photos with whichever AI provider passwords.yaml picks:
//
//   nutritionAiProvider: gemini   (default, free tier)
//   nutritionAiProvider: claude   (paid)
//
// It's read on every scan, so changing it only needs a server restart.
class NutritionAiService {
  static const defaultProvider = 'gemini';

  final Map<String, NutritionAiProvider> _providers;

  NutritionAiService({Map<String, NutritionAiProvider>? providers})
    : _providers =
          providers ??
          {'gemini': GeminiNutritionAi(), 'claude': ClaudeNutritionAi()};

  Future<NutritionAnalysis> analyze(Session session, Uint8List jpeg) =>
      _provider(session).analyze(session, jpeg);

  Future<Map<String, dynamic>> generateJson(
    Session session, {
    required String system,
    required String prompt,
    required Map<String, dynamic> schema,
  }) => _provider(
    session,
  ).generateJson(session, system: system, prompt: prompt, schema: schema);

  NutritionAiProvider _provider(Session session) {
    final name = session.passwords['nutritionAiProvider'] ?? defaultProvider;
    final provider = _providers[name];
    if (provider == null) {
      session.log(
        'Unknown nutritionAiProvider "$name" in config/passwords.yaml. '
        'Use one of: ${_providers.keys.join(', ')}',
        level: LogLevel.error,
      );
      throw scannerUnavailable();
    }
    return provider;
  }
}

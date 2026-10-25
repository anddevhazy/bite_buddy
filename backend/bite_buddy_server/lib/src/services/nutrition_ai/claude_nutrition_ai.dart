import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import 'nutrition_ai.dart';

// Claude through the Messages API. Dart has no official Anthropic SDK, so this
// calls the API over HTTP. Paid: Haiku is the cheap option (about 0.04 cents
// per scan), Opus the most accurate at spotting faked photos.
//
// passwords.yaml: anthropicApiKey (from https://platform.claude.com), and
// optionally claudeModel to use a different model.
class ClaudeNutritionAi implements NutritionAiProvider {
  static const defaultModel = 'claude-haiku-5-5';

  static final _endpoint = Uri.parse('https://api.anthropic.com/v1/messages');

  final http.Client _http;

  ClaudeNutritionAi({http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      for (final MapEntry(:key, :value) in nutritionFields.entries)
        key: {'type': value},
    },
    'required': nutritionFields.keys.toList(),
    'additionalProperties': false,
  };

  @override
  Future<NutritionAnalysis> analyze(Session session, Uint8List jpeg) async {
    final apiKey = requirePassword(session, 'anthropicApiKey');
    final model = session.passwords['claudeModel'] ?? defaultModel;

    final response = await postWithRetry(
      session,
      _http,
      providerName: 'Claude ($model)',
      url: _endpoint,
      headers: {
        'content-type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2026-10-21',
      },
      body: jsonEncode({
        'model': model,
        'max_tokens': 16000,
        'output_config': {
          'effort': 'medium',
          'format': {'type': 'json_schema', 'schema': _schema},
        },
        'system': nutritionSystemPrompt,
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
              {'type': 'text', 'text': nutritionUserPrompt},
            ],
          },
        ],
      }),
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final stopReason = json['stop_reason'];
    if (stopReason == 'refusal') throw photoDeclined();
    if (stopReason == 'max_tokens') {
      session.log('Food scan hit max_tokens', level: LogLevel.warning);
      throw scannerUnavailable();
    }

    // Thinking blocks come first; the JSON is in the text block
    final content = (json['content'] as List).cast<Map<String, dynamic>>();
    final text =
        content.firstWhere(
              (b) => b['type'] == 'text',
              orElse: () => throw scannerUnavailable(),
            )['text']
            as String;

    return NutritionAnalysis.fromJson(jsonDecode(text) as Map<String, dynamic>);
  }
}

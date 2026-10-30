import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import 'nutrition_ai.dart';

// Google Gemini through the generateContent REST API. gemini-3.5-flash-lite is
// on Gemini's free tier and answers in a few seconds; gemini-3.8-flash is
// stronger but often overloaded for free-tier keys (scans took 90s+ or got
// 503s in testing). Note that Google may use free-tier requests (including
// the meal photos) to improve its products; switch to a paid key before
// launch if that matters.
//
// passwords.yaml: geminiApiKey (from https://aistudio.google.com), and
// optionally geminiModel to use a different model.
class GeminiNutritionAi implements NutritionAiProvider {
  static const defaultModel = 'gemini-3.5-flash-lite';

  final http.Client _http;

  GeminiNutritionAi({http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  // Gemini takes a subset of OpenAPI 3.0 schemas, with upper-case type names
  static final Map<String, dynamic> _schema = {
    'type': 'OBJECT',
    'properties': {
      for (final MapEntry(:key, :value) in nutritionFields.entries)
        key: {'type': value.toUpperCase()},
    },
    'required': nutritionFields.keys.toList(),
    'propertyOrdering': nutritionFields.keys.toList(),
  };

  // Turns a standard JSON schema into Gemini's format: upper-case types, no
  // additionalProperties, and properties kept in the order given
  static Map<String, dynamic> toGeminiSchema(Map<String, dynamic> schema) => {
    for (final MapEntry(:key, :value) in schema.entries)
      if (key == 'type')
        key: (value as String).toUpperCase()
      else if (key == 'properties')
        key: {
          for (final p in (value as Map<String, dynamic>).entries)
            p.key: toGeminiSchema(p.value as Map<String, dynamic>),
        }
      else if (key == 'items')
        key: toGeminiSchema(value as Map<String, dynamic>)
      else if (key != 'additionalProperties')
        key: value,
    if (schema['properties'] case final Map<String, dynamic> properties)
      'propertyOrdering': properties.keys.toList(),
  };

  @override
  Future<NutritionAnalysis> analyze(Session session, Uint8List jpeg) async {
    final text = await _generate(
      session,
      system: nutritionSystemPrompt,
      parts: [
        {
          'inlineData': {'mimeType': 'image/jpeg', 'data': base64Encode(jpeg)},
        },
        {'text': nutritionUserPrompt},
      ],
      schema: _schema,
    );
    try {
      return NutritionAnalysis.fromJson(
        jsonDecode(text) as Map<String, dynamic>,
      );
    } on FormatException {
      session.log('Gemini returned invalid JSON: $text', level: LogLevel.error);
      throw scannerUnavailable();
    } on TypeError {
      session.log('Gemini JSON missing fields: $text', level: LogLevel.error);
      throw scannerUnavailable();
    }
  }

  @override
  Future<Map<String, dynamic>> generateJson(
    Session session, {
    required String system,
    required String prompt,
    required Map<String, dynamic> schema,
  }) async {
    final text = await _generate(
      session,
      system: system,
      parts: [
        {'text': prompt},
      ],
      schema: toGeminiSchema(schema),
    );
    try {
      return jsonDecode(text) as Map<String, dynamic>;
    } on FormatException {
      session.log('Gemini returned invalid JSON: $text', level: LogLevel.error);
      throw scannerUnavailable();
    }
  }

  // Sends one request and returns the answer's text
  Future<String> _generate(
    Session session, {
    required String system,
    required List<Map<String, dynamic>> parts,
    required Map<String, dynamic> schema,
  }) async {
    final apiKey = requirePassword(session, 'geminiApiKey');
    final model = session.passwords['geminiModel'] ?? defaultModel;

    final response = await postWithRetry(
      session,
      _http,
      providerName: 'Gemini ($model)',
      url: Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/'
        '$model:generateContent',
      ),
      headers: {'content-type': 'application/json', 'x-goog-api-key': apiKey},
      body: jsonEncode({
        'systemInstruction': {
          'parts': [
            {'text': system},
          ],
        },
        'contents': [
          {'role': 'user', 'parts': parts},
        ],
        'generationConfig': {
          'responseMimeType': 'application/json',
          'responseSchema': schema,
        },
      }),
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    // The whole prompt was blocked (e.g. by a safety filter)
    final blockReason = (json['promptFeedback'] as Map?)?['blockReason'];
    if (blockReason != null) {
      session.log(
        'Gemini blocked the request: $blockReason',
        level: LogLevel.info,
      );
      throw photoDeclined();
    }

    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) throw scannerUnavailable();
    final candidate = candidates.first as Map<String, dynamic>;

    final finishReason = candidate['finishReason'] as String?;
    if (finishReason != null && finishReason != 'STOP') {
      session.log(
        'Gemini stopped with $finishReason',
        level: LogLevel.warning,
      );
      // Token limits are our problem; anything else is the model declining
      throw finishReason == 'MAX_TOKENS'
          ? scannerUnavailable()
          : photoDeclined();
    }

    // Skip any thought parts; the JSON is in the answer text
    final answer = ((candidate['content'] as Map?)?['parts'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    final text = answer
        .where((p) => p['thought'] != true && p['text'] is String)
        .map((p) => p['text'] as String)
        .join();
    if (text.isEmpty) throw scannerUnavailable();
    return text;
  }
}

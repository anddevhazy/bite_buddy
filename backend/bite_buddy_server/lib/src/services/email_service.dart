import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

// Sends sign-up and password-reset codes through Resend (https://resend.com).
//
// passwords.yaml: resendApiKey, and optionally resendFrom, e.g.
// "Bite Buddy <hello@your-domain.com>" once your domain is verified in
// Resend. Without a domain, Resend's onboarding@resend.dev sender only
// delivers to the email address of your own Resend account.
//
// With no resendApiKey (e.g. local development) nothing is sent and the code
// is only logged.
class EmailService {
  static const defaultFrom = 'Bite Buddy <onboarding@resend.dev>';
  static final _endpoint = Uri.parse('https://api.resend.com/emails');

  final http.Client _http;

  EmailService({http.Client? httpClient}) : _http = httpClient ?? http.Client();

  Future<void> sendCode(
    Session session, {
    required String to,
    required String subject,
    required String heading,
    required String code,
  }) async {
    final apiKey = session.passwords['resendApiKey'];
    if (apiKey == null || apiKey.isEmpty) {
      session.log('resendApiKey not set; email to $to not sent');
      return;
    }
    final from = session.passwords['resendFrom'] ?? defaultFrom;
    try {
      final response = await _http
          .post(
            _endpoint,
            headers: {
              'authorization': 'Bearer $apiKey',
              'content-type': 'application/json',
            },
            body: jsonEncode({
              'from': from,
              'to': [to],
              'subject': subject,
              'text':
                  '$heading\n\nYour code: $code\n\n'
                  "If you didn't ask for this, you can ignore this email.",
              'html': _html(heading, code),
            }),
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode >= 300) {
        session.log(
          'Resend returned ${response.statusCode}: ${response.body}',
          level: LogLevel.error,
        );
      }
    } on Exception catch (e) {
      session.log('Resend request failed: $e', level: LogLevel.error);
    }
  }

  String _html(String heading, String code) =>
      '''
<div style="font-family:Arial,sans-serif;max-width:420px;margin:auto;padding:24px;background:#0B231D;color:#ffffff;border-radius:16px">
  <h2 style="margin:0 0 12px">🐾 Bite Buddy</h2>
  <p style="margin:0 0 16px">${const HtmlEscape().convert(heading)}</p>
  <p style="font-size:32px;font-weight:bold;letter-spacing:6px;color:#12C48B;margin:0 0 16px">$code</p>
  <p style="color:#B7C4BF;font-size:13px;margin:0">If you didn't ask for this, you can ignore this email.</p>
</div>''';
}

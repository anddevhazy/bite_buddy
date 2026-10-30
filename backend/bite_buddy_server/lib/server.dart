import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/serverpod.dart';
import 'src/services/email_service.dart';
import 'src/web/keepsake_routes.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(args);

  // JWTs for API auth, and email + password as the sign-in method
  pod.initializeAuthServices(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Public keepsake NFT metadata and card pictures, read by wallets
  pod.webServer.addRoute(KeepsakeRoute(), 'keepsakes/**');

  await pod.start();
}

final _email = EmailService();

// Codes are emailed through Resend (when resendApiKey is set), logged, and
// in development also printed to the `serverpod start` terminal.
Future<void> _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  session.log('[EmailIdp] Registration code sent to $email');
  await _email.sendCode(
    session,
    to: email,
    subject: 'Your Bite Buddy sign-up code',
    heading: 'Welcome! Enter this code in the app to finish signing up.',
    code: verificationCode,
  );
  _printInDevelopment(
    session,
    'Registration code for $email: $verificationCode',
  );
}

Future<void> _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  session.log('[EmailIdp] Password reset code sent to $email');
  await _email.sendCode(
    session,
    to: email,
    subject: 'Your Bite Buddy password reset code',
    heading: 'Enter this code in the app to choose a new password.',
    code: verificationCode,
  );
  _printInDevelopment(
    session,
    'Password reset code for $email: $verificationCode',
  );
}

// Session logs are stored in the database but not shown in the `serverpod
// start` view, so print sign-up codes there too. Never in staging/production.
void _printInDevelopment(Session session, String message) {
  if (session.serverpod.runMode == ServerpodRunMode.development) {
    // ignore: avoid_print
    print('📧 $message');
  }
}

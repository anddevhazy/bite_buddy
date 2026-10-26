import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/serverpod.dart';

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

  await pod.start();
}

// TODO: send these through an email service (Resend, like Attend). Until
// then the codes are written to the server log so you can sign up locally,
// and in development also printed to the `serverpod start` terminal.
void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
  _printInDevelopment(session, 'Registration code for $email: $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
  _printInDevelopment(session, 'Password reset code for $email: $verificationCode');
}

// Session logs are stored in the database but not shown in the `serverpod
// start` view, so print sign-up codes there too. Never in staging/production.
void _printInDevelopment(Session session, String message) {
  if (session.serverpod.runMode == ServerpodRunMode.development) {
    // ignore: avoid_print
    print('📧 $message');
  }
}

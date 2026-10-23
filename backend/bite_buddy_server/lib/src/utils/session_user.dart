import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

extension SessionUser on Session {
  // The signed-in user's id. Only call this from endpoints with
  // requireLogin, where Serverpod has already rejected anonymous calls.
  UuidValue get userId => authenticated!.authUserId;
}

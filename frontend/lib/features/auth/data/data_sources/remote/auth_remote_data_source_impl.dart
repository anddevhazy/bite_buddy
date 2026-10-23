import 'dart:async';

import 'package:bite_buddy/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

// Serverpod's auth session manager stores the JWTs in secure storage and
// refreshes them; this just exposes its state to the rest of the app.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  bool isSignedIn() => client.auth.isAuthenticated;

  @override
  Stream<bool> watchSignedIn() {
    late final StreamController<bool> controller;
    void listener() => controller.add(client.auth.isAuthenticated);

    controller = StreamController<bool>(
      onListen: () => client.auth.authInfoListenable.addListener(listener),
      onCancel: () => client.auth.authInfoListenable.removeListener(listener),
    );
    return controller.stream.distinct();
  }

  @override
  Future<void> signOut() => client.auth.signOutDevice();
}

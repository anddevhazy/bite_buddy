abstract class AuthRemoteDataSource {
  bool isSignedIn();
  Stream<bool> watchSignedIn();
  Future<void> signOut();
}

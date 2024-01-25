import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  const AuthService();
  User? currentUser() => FirebaseAuth.instance.currentUser;

  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}

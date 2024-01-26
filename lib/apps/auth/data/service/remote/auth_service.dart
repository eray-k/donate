import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  const AuthService();
  User? currentUser() => FirebaseAuth.instance.currentUser;

  Future<UserCredential> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    //TODO: Add user to firestore database (firstName, lastName, email, uid)
  }
}

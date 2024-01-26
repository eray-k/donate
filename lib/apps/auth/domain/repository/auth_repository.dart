import 'dart:async';

import 'package:donate/apps/auth/data/service/remote/auth_service.dart';
import 'package:donate/core/toolset/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/account.dart';

class AuthRepository {
  final AuthService authService;
  const AuthRepository(this.authService);

  User? get currentUser => authService.currentUser();

  FutureOr<DataState<User>> login(String email, String password) async {
    try {
      final credential = await authService.loginWithEmailAndPassword(
          email: email, password: password);
      print(
          "signed in as: $credential, addInfo: ${credential.additionalUserInfo}, user: ${credential.user}");
      return DataSuccess(
          credential.user!); //What about no user found for this email?
    } on FirebaseAuthException catch (e) {
      return DataFailed<User>(e);
    }
  }

  FutureOr<DataState<User>> register(Account account) async {
    try {
      final credential = await authService.registerWithEmailAndPassword(
          email: account.email, password: account.password);
      print(
          "registered account: $credential, addInfo: ${credential.additionalUserInfo}, user: ${credential.user}");
      return DataSuccess(credential.user!);
    } on FirebaseAuthException catch (e) {
      return DataFailed<User>(e);
    }
  }
}

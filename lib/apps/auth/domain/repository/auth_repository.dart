import 'dart:async';

import 'package:donate/apps/auth/data/service/remote/auth_service.dart';
import 'package:donate/core/toolset/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../model/account.dart';

class AuthRepository {
  final AuthService authService;
  const AuthRepository(this.authService);

  User? get currentUser => authService.currentUser();

  FutureOr<DataState<User>> loginWithEmailAndPassword(
      String email, String password) async {
    return _login(email: email, password: password);
  }

  FutureOr<DataState<User>> loginWithGoogle() async {
    return _login(withGoogle: true);
  }

  FutureOr<DataState<User>> _login(
      {String email = '',
      String password = '',
      bool withGoogle = false}) async {
    try {
      final credential = withGoogle
          ? await authService.loginWithGoogle()
          : await authService.loginWithEmailAndPassword(
              email: email, password: password);
      credential.user?.reload();
      if (!(credential.user?.emailVerified ?? true)) {
        debugPrint("Email not verified: ${credential.user?.emailVerified}");
        await credential.user?.sendEmailVerification();
      }
      debugPrint("Signed in as: ${credential.user?.email}");
      return DataSuccess(
          credential.user!); //What about no user found for this email?
    } on FirebaseAuthException catch (e) {
      debugPrint("Error occured during login: ${e.message}");
      return DataFailed<User>(e);
    }
  }

  FutureOr<DataState<User>> register(Account account, String password) async {
    try {
      final credential = await authService.registerWithEmailAndPassword(
          email: account.email, password: password);
      debugPrint("Registered account: ${credential.user?.email}");
      return DataSuccess(credential.user!);
    } on FirebaseAuthException catch (e) {
      debugPrint("Error occured during register: ${e.message}");
      return DataFailed<User>(e);
    }
  }
}

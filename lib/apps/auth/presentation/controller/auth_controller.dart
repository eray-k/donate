import 'dart:async';

import 'package:donate/core/toolset/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/account.dart';
import '../../domain/repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository;
  const AuthController(this._authRepository);
  FutureOr<DataState<User>> loginWithEmailAndPassword(String email,
      String password, Function(FirebaseAuthException e) onError) async {
    final data =
        await _authRepository.loginWithEmailAndPassword(email, password);
    if (data is DataFailed<User>) {
      onError(data.error as FirebaseAuthException);
    }
    return data;
  }

  FutureOr<DataState<User>> loginWithGoogle(
      Function(FirebaseAuthException e) onError) async {
    final data = await _authRepository.loginWithGoogle();
    if (data is DataFailed<User>) {
      onError(data.error as FirebaseAuthException);
    }
    return data;
  }

  Future<DataState<User>> register(Account account) async {
    final data = await _authRepository.register(account);
    if (data is DataFailed<User>) {}
    return data;
  }
}

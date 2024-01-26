import 'dart:async';

import 'package:donate/core/toolset/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/model/account.dart';
import '../../domain/repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository;
  const AuthController(this._authRepository);
  FutureOr<DataState<User>> login(String email, String password,
      Function(FirebaseAuthException e) onError) async {
    final data = await _authRepository.login(email, password);
    if (data is DataSuccess<User>) {
      print("Login successful");
      print("Current user changed to: ${data.data?.email}");
    } else {
      print("Login failed: ${data.error}");
      onError(data.error as FirebaseAuthException);
    }
    return data;
  }

  Future<DataState<User>> register(Account account) async {
    final data = await _authRepository.register(account);
    if (data is DataSuccess<User>) {
      print("Login successful");
      print("Current user changed to: ${data.data?.email}");
    } else {
      print("Login failed: ${data.error}");
    }
    return data;
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate/apps/auth/data/service/remote/auth_service.dart';
import 'package:donate/apps/map_app/data/service/local/location_service.dart';
import 'package:donate/core/toolset/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../../dependency_injection.dart';
import '../model/account.dart';

class AuthRepository {
  Account? currentAccount;
  final AuthService authService;
  AuthRepository(this.authService);
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
    FirebaseAuth.instance.userChanges().listen((event) {
      canUpdate = true;
    });
    try {
      final credential = withGoogle
          ? await authService.loginWithGoogle()
          : await authService.loginWithEmailAndPassword(
              email: email, password: password);
      if (credential.user == null) {
        return DataFailed<User>(FirebaseAuthException(
            code: 'user-not-found', message: 'User not found'));
      }
      final user = credential.user!;
      user.reload();
      if (!user.emailVerified) {
        debugPrint("Email not verified: ${user.emailVerified}");
        await user.sendEmailVerification();
      }
      debugPrint("Signed in as: ${user.email}");
      await getCurrentAccount(refresh: true);
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
      await newAccount(account);
      return DataSuccess(credential.user!);
    } on FirebaseAuthException catch (e) {
      debugPrint("Error occured during register: ${e.message}");
      return DataFailed<User>(e);
    }
  }

  Future<void> logout() async {
    currentAccount = null;
    await FirebaseAuth.instance.signOut();
  }

  FutureOr<Account> newAccount(Account account) async {
    if (currentAccount != null) {
      throw Exception(
          "On authRepository: Account field is not null, cannot create new account.");
    }
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await docRef.get().then((doc) async {
      if (doc.exists) {
        debugPrint("User exists, cannot create");
      } else {
        debugPrint("User does not exist, creating new account in database");
        currentAccount = account;
        await docRef.set(currentAccount!.toDocument());
      }
    });
    await updateLocation();
    debugPrint("Current account: $currentAccount");
    return currentAccount!;
  }

  FutureOr<Account> getCurrentAccount({bool refresh = false}) async {
    if (!refresh && currentAccount != null) {
      return currentAccount!;
    }
    if (currentUser == null) return Future.error("User is null");
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await docRef.get().then((doc) async {
      if (doc.exists) {
        debugPrint("User exists, retrieving data");
        currentAccount = Account.fromDocument(doc.data()!);
      } else {
        debugPrint("User does not exist, creating new account in database");
        currentAccount = Account(
          displayName: currentUser!.displayName ?? '',
          email: currentUser!.email ?? '',
          position: null,
        );
        await docRef.set(currentAccount!.toDocument());
      }
      //Store FCM token to send notifications later
      docRef.update({'fcmToken': await FirebaseMessaging.instance.getToken()});
    });
    await updateLocation();
    debugPrint("Current account: $currentAccount");
    return currentAccount!;
  }

  Future<void> updateCurrentAccount() async {
    if (currentUser == null) {
      debugPrint("Current user is null, cannot update account");
      return;
    }
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await docRef.update(currentAccount!.toDocument());
  }

  bool canUpdate = true;
  Future<void> updateLocation() async {
    if (!canUpdate) return;
    if (currentAccount == null) {
      debugPrint("Current account is null, cannot update location");
      return;
    }
    canUpdate = false;
    Future.delayed(const Duration(minutes: 3), () => canUpdate = true);
    final data = await sl<LocationService>().getLocation();
    currentAccount!.setPosition(data.latitude, data.longitude);
    debugPrint("Updating location: ${currentAccount!.position?.timestamp}");
    await updateCurrentAccount();
  }
}

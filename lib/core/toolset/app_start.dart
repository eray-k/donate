import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../firebase_options.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.data}");
}

Future<void> initalizeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (const bool.fromEnvironment("USE_FIREBASE_EMU")) {
    const host = "144.122.251.204";
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    debugPrint(
        "Using Firebase Emulator at $host:9099 (auth) and $host:8080 (firestore)");
  }

  await FirebaseMessaging.instance.requestPermission();
  debugPrint("Checking FCM token...");
  debugPrint("FCM Token: ${await FirebaseMessaging.instance.getToken()}");
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    debugPrint("FCM Token changed: $fcmToken"); //TODO: Update token in db
  }).onError((err) {
    // Error getting token.
  });
}

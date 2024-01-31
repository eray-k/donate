import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

Future<void> initalizeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (const bool.fromEnvironment("USE_FIREBASE_EMU")) {
    String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
    int authConfigPort = const int.fromEnvironment("AUTH_EMU_PORT");
    int firestoreConfigPort = const int.fromEnvironment("FS_EMU_PORT");
    String host =
        configHost.isNotEmpty ? configHost : "10.0.2.2"; // Android localhost
    int authPort = authConfigPort != 0 ? authConfigPort : 9099;
    int firestorePort = firestoreConfigPort != 0 ? firestoreConfigPort : 8080;

    await FirebaseAuth.instance.useAuthEmulator(host, authPort);
    FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
    debugPrint(
        "Using Firebase Emulator at $host:$authPort (auth) and $host:$firestorePort (firestore)");
  }
}

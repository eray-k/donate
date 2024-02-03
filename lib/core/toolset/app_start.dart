import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

Future<void> initalizeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (const bool.fromEnvironment("USE_FIREBASE_EMU")) {
    const host = "192.168.1.31";
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    debugPrint(
        "Using Firebase Emulator at $host:9099 (auth) and $host:8080 (firestore)");
  }
}

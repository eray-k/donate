import 'package:citrus_blood/apps/auth/presentation/pages/login_page.dart';
import 'package:citrus_blood/core/secrets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // remove debug banner
      theme: theme,
      home: const LoginPage(),
    );
  }
}

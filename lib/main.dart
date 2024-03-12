import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:donate/apps/auth/presentation/pages/account_edit_page.dart';
import 'package:donate/apps/auth/presentation/pages/signup_page.dart';
import 'package:donate/apps/map_app/presentation/pages/list_view.dart';
import 'package:donate/core/toolset/app_start.dart';
import 'package:donate/core/toolset/requirements_watcher.dart';
import 'package:donate/core/toolset/lifecycle_watcher.dart';
import 'package:donate/core/ui/widgets/custom_progress_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:donate/apps/auth/presentation/pages/login_page.dart';
import 'package:donate/core/theme/theme.dart';
import 'package:donate/dependency_injection.dart';
import 'apps/auth/presentation/pages/account_view_page.dart';
import 'apps/map_app/presentation/pages/about_page.dart';
import 'apps/map_app/presentation/pages/home_page.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initalizeFirebase();
  await inject(); //Dependency Injection
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate',
      debugShowCheckedModeBanner: false, // remove debug banner
      theme: MyTheme.theme,
      initialRoute: '/', // initial route
      routes: {
        '/': (context) => const MyInitialRoute(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/account': (context) => const AccountViewPage(),
        '/list': (context) => const ListAlertsPage(),
        '/edit': (context) => const AccountEditPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class MyInitialRoute extends StatelessWidget {
  const MyInitialRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          FlutterNativeSplash.remove();
          if (snapshot.hasData) {
            return RequirementsWatcher(
                child: LifecycleWatcher(
                    child: FutureBuilder(
                        future: Future(() async =>
                            await sl<AuthRepository>().getCurrentAccount()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) return const HomePage();
                          if (snapshot.hasError) {
                            debugPrint(snapshot.error.toString());
                            return const Scaffold(
                              body: Center(
                                child: Text(
                                  'Sorry, please try again later.',
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                ),
                              ),
                            );
                          }
                          return const CustomProgressIndicator();
                        })));
          } else {
            return const RequirementsWatcher(child: LoginPage());
          }
        });
  }
}

import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:donate/apps/auth/presentation/widgets/custom_field_widget.dart';
import 'package:donate/core/ui/widgets/wide_elevated_button.dart';
import 'package:donate/dependency_injection.dart';
import 'package:flutter/material.dart';

import '../../../../core/toolset/ui/ui_tools.dart';
import '../../../map_app/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool termsAccepted = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Avoids overflow
      body: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage("assets/images/logo_flat.png"),
              width: 145,
            ),
            verticalSpacer(45.0),
            CustomTextField(
                controller: emailController,
                icon: Icons.email,
                hintText: "Email Address"),
            verticalSpacer(16.0),
            CustomTextField(
                controller: passwordController,
                icon: Icons.lock,
                hintText: "Password"),
            verticalSpacer(16.0),
            WideElevatedButton(
                // Login Button
                onPressed: () async {
                  //Login using email and password
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logging in...")));
                  await sl<AuthRepository>().login(emailController.text.trim(),
                      passwordController.text.trim());
                  print("currentUser: ${sl<AuthRepository>().currentUser}");
                },
                child: const Text(
                  "Sign In",
                  textScaleFactor: 1.5,
                )),
            TextButton(
              onPressed: () {},
              child: Text("Don't have an account?",
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.4))),
            ),
            WideElevatedButton(
                onPressed: () {},
                style: ElevatedButtonTheme.of(context).style?.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.blue),
                    ),
                child: const Text("Continue with Google")),
            verticalSpacer(4.0),
            // Terms and Conditions

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      termsAccepted = value!;
                    });
                  },
                ),
                const SizedBox(
                  width: 200,
                  child: Text(
                    "I agree to the Terms of Service and Privacy Policy",
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

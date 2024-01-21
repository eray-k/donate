import 'package:citrus_blood/core/ui/widgets.dart/wide_elevated_button.dart';
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
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage("assets/images/logo_shadow.png"),
              width: 100,
            ),
            verticalSpacer(16.0), //Vertical Spacer
            TextField(
              // Email field
              controller: emailController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.primary,
                ), // Email Icon
                hintText: 'Email Address',
                border: const OutlineInputBorder(),
              ),
            ),
            verticalSpacer(16.0),
            TextField(
              // Password field
              controller: passwordController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.primary,
                ), // Lock Icon
                hintText: 'Password',
                border: const OutlineInputBorder(),
              ),
            ),
            verticalSpacer(16.0),
            WideElevatedButton(
                // Login Button
                onPressed: () {
                  if (emailController.text == "asdf" &&
                      passwordController.text == "1234") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Invalid Credentials"),
                    ));
                  }
                },
                child: const Text("Sign In")),
            verticalSpacer(4.0),
            TextButton(
              onPressed: () {},
              child: const Text("Don't have an account?",
                  style: TextStyle(fontSize: 12)),
            ),
            verticalSpacer(12.0),

            WideElevatedButton(
                // Login Button
                onPressed: () {
                  //TODO: Implement Google Sign In
                },
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

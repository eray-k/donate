import 'package:donate/core/toolset/ui/ui_tools.dart';

import '../controller/auth_controller.dart';
import '../../../../core/ui/widgets/wide_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../dependency_injection.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool signinIn = false;

  @override
  Widget build(BuildContext context) {
    return WideElevatedButton(
        style: ElevatedButtonTheme.of(context).style?.copyWith(
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(2)),
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF699BF7))),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Image.asset(
                "assets/images/google_logo.png",
              ),
            ),
            horizontalSpacer(16),
            const Text("Sign in with Google")
          ],
        ),
        onPressed: () async {
          await sl<AuthController>().loginWithGoogle((e) {
            Scaffold.of(context).showBottomSheet((context) => Container(
                  color: Colors.red,
                  child: Text(
                      "${e.message}"), //FIXME: There might be a security issue here
                ));
          });
        });
  }
}

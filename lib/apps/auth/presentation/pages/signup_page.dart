import 'package:donate/apps/auth/domain/model/account.dart';
import 'package:donate/apps/auth/presentation/controller/auth_controller.dart';
import 'package:donate/core/toolset/ui/ui_tools.dart';
import 'package:flutter/material.dart';

import '../../../../core/toolset/data_state.dart';
import '../../../../core/ui/widgets/wide_elevated_button.dart';
import '../../../../dependency_injection.dart';
import '../widgets/custom_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool termsAccepted = false;
  bool signingUp = false;
  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [
            Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextField(
                    controller: firstNameController,
                    hintText: "First Name",
                    keyboardType: TextInputType.name,
                  ),
                  verticalSpacer(16),
                  CustomTextField(
                    controller: lastNameController,
                    hintText: "Last Name",
                    keyboardType: TextInputType.name,
                  ),
                  verticalSpacer(16),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticalSpacer(16),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    isPassword: true,
                  ),
                  verticalSpacer(16),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    isPassword: true,
                  ),
                  verticalSpacer(16),
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
                  ),
                  verticalSpacer(16),
                  WideElevatedButton(
                    onPressed: () async {
                      if (!termsAccepted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Please accept the terms and conditions")));
                        return;
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Passwords do not match")));
                        return;
                      }
                      setState(() {
                        signingUp = true;
                      });
                      //Register using email and password
                      await sl<AuthController>()
                          .register(Account(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text))
                          .then((value) {
                        if (value is DataSuccess) {
                          Navigator.of(context).popAndPushNamed('/');
                        }
                        setState(() {
                          signingUp = false;
                        });
                      });
                    },
                    enabled: !signingUp,
                    child: const Text("Register", textScaleFactor: 1.5),
                  ),
                  verticalSpacer(16),
                  Text('or',
                      style: TextStyle(color: Colors.black.withOpacity(0.4))),
                  verticalSpacer(16),
                  //TODO: Google signup button
                  WideElevatedButton(
                      onPressed: () {},
                      style: ElevatedButtonTheme.of(context).style?.copyWith(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.blue),
                          ),
                      child: const Text("Continue with Google")),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
            )
          ]),
        ));
  }
}

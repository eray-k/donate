import 'package:donate/core/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text(
              "What is it that we are doing here?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "A message from the developers.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(aboutMessage),
          ],
        ));
  }
}

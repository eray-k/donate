import 'package:flutter/material.dart';

class WideElevatedButton extends StatelessWidget {
  const WideElevatedButton(
      {super.key, required this.child, this.onPressed, this.style});
  final Function()? onPressed;
  final ButtonStyle? style;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: (style ?? ElevatedButtonTheme.of(context).style)?.copyWith(
        minimumSize: MaterialStateProperty.resolveWith(
            (states) => const Size(double.infinity, 50)),
      ),
      child: child,
    );
  }
}

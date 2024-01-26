import 'package:flutter/material.dart';

class WideElevatedButton extends StatelessWidget {
  const WideElevatedButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.style,
      this.enabled = true});
  final Function()? onPressed;
  final ButtonStyle? style;
  final Widget child;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: (style ?? ElevatedButtonTheme.of(context).style)?.copyWith(
        minimumSize: MaterialStateProperty.resolveWith(
            (states) => const Size(double.infinity, 50)),
        maximumSize: MaterialStateProperty.resolveWith(
            (states) => const Size(double.infinity, 50)),
      ),
      child: enabled
          ? child
          : const Center(
              child: SizedBox(
                  width: 25, height: 25, child: CircularProgressIndicator())),
    );
  }
}

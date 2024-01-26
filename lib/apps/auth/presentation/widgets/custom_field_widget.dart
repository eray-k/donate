import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.icon,
      this.hintText = '',
      this.keyboardType,
      this.isPassword = false});
  final TextEditingController? controller;
  final IconData? icon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.4)),
      ),
      child: TextField(
        // Email field
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        decoration: InputDecoration(
          icon: icon != null
              ? Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                )
              : null, // Email Icon
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

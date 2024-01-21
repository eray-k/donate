import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, this.controller, required this.icon, this.hintText = ''});
  final TextEditingController? controller;
  final IconData icon;
  final String hintText;

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
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ), // Email Icon
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

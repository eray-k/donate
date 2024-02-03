import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({super.key, this.bloodType});
  final String? bloodType;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD0D0D0), Color(0xFF939393)],
        ),
      ),
      child: bloodType != null
          ? Text(
              bloodType!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            )
          : const Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
    );
  }
}

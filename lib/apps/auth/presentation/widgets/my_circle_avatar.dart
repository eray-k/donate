import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({super.key, this.bloodType, required this.size});
  final String? bloodType;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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
          ? Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: size * .8,
                  color: Colors.black.withOpacity(0.1),
                ),
                Text(
                  bloodType!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.4,
                  ),
                ),
              ],
            )
          : Icon(
              Icons.person,
              size: size / 2,
              color: Colors.white,
            ),
    );
  }
}

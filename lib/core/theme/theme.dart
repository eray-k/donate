import 'package:flutter/material.dart';

class MyTheme {
  static const primaryColor = Color(0xFFE41027);
  static const surfaceColor = Colors.white;
  static final colorScheme =
      ColorScheme.fromSeed(seedColor: MyTheme.primaryColor);
  static final theme = ThemeData(
    colorScheme: colorScheme,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: surfaceColor,
        backgroundColor: primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors.black.withOpacity(0.7),
          minimumSize: const Size.fromHeight(0),
          alignment: AlignmentDirectional.centerStart,
          textStyle: const TextStyle(fontSize: 20)),
    ),
    useMaterial3: true,
  );
}

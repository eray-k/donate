import 'package:flutter/material.dart';

const primaryColor = Color(0xFFE41027);
const surfaceColor = Colors.white;
final colorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
final theme = ThemeData(
  colorScheme: colorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: surfaceColor,
      backgroundColor: primaryColor,
    ),
  ),
  
  useMaterial3: true,
);

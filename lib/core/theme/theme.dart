import 'package:flutter/material.dart';

const primaryColor = Color(0xFFE41027);
const surfaceColor = Colors.white;
final colorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
final theme = ThemeData(
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
        foregroundColor: Colors.grey,
        minimumSize: const Size.fromHeight(0),
        alignment: AlignmentDirectional.centerStart,
        textStyle: const TextStyle(fontSize: 20)),
  ),
  useMaterial3: true,
);

import 'package:flutter/material.dart';
import 'custom_theme.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: const Color(0xFF111B21),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF111B21),
      titleTextStyle: const TextStyle(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.grey[400]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[400],
      ),
    ),
    extensions: [
      CustomThemeExtension.darkMode,
    ],
  );
}

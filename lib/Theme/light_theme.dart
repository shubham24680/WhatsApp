import 'package:flutter/material.dart';
import 'custom_theme.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.teal[700]),
      actionsIconTheme: IconThemeData(color: Colors.grey[700]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[700],
        shadowColor: Colors.transparent,
      ),
    ),
    extensions: [
      CustomThemeExtension.lightMode,
    ],
  );
}

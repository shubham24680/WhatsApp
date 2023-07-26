import 'package:flutter/material.dart';
import 'custom_theme.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.teal[700]),
      actionsIconTheme: IconThemeData(color: Colors.grey[700]),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[600],
        shadowColor: Colors.transparent,
      ),
    ),
    extensions: [
      CustomThemeExtension.lightMode,
    ],
  );
}

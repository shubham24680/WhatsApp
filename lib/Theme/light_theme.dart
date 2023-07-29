import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_theme.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.varelaRound(
        color: Colors.teal[600],
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
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
        textStyle: GoogleFonts.varelaRound(fontSize: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.green[400],
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    extensions: [
      CustomThemeExtension.lightMode,
    ],
  );
}

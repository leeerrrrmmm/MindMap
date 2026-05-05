import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFFFB605E);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF252B39);
}

class AppThemeData {
  static ThemeData get light => ThemeData(
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: AppTheme.backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppTheme.secondaryColor,
      tertiary: AppTheme.accentColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppTheme.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppTheme.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: AppTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

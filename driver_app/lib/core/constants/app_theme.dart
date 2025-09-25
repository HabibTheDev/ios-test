import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';

class AppThemes {
  const AppThemes._();

  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),
      scaffoldBackgroundColor: AppColors.lightBgColor,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.lightCursorColor),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: Colors.white)),
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.lightTextColor),
        displayMedium: TextStyle(color: AppColors.lightTextColor),
        displaySmall: TextStyle(color: AppColors.lightTextColor),
        headlineMedium: TextStyle(color: AppColors.lightTextColor),
        headlineSmall: TextStyle(color: AppColors.lightTextColor),
        titleLarge: TextStyle(color: AppColors.lightTextColor),
        titleMedium: TextStyle(color: AppColors.lightTextColor),
        titleSmall: TextStyle(color: AppColors.lightTextColor),
        bodyLarge: TextStyle(color: AppColors.lightTextColor),
        bodyMedium: TextStyle(color: AppColors.lightTextColor),
        bodySmall: TextStyle(color: AppColors.lightTextColor),
        labelLarge: TextStyle(color: AppColors.lightTextColor),
        labelSmall: TextStyle(color: AppColors.lightTextColor),
      ));
}

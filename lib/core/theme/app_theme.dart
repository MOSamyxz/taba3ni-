import 'package:flutter/material.dart';
import 'package:taba3ni/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
     fontFamily: 'Roboto', // أو أي خط تريده
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.pYellow,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
     
 
 
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.lightTextPrimary),

      bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),

      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),

      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
        primaryColor: AppColors.primary,

    scaffoldBackgroundColor: AppColors.darkBackground,
     fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.darkTextPrimary),

      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),

      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),

      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
    ),
  );
}

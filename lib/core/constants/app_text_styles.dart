import 'package:flutter/material.dart';

class AppTextStyles {
  final BuildContext context;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  AppTextStyles(this.context)
      : textTheme = Theme.of(context).textTheme,
        colorScheme = Theme.of(context).colorScheme;

  // Headings
  TextStyle get heading1 => textTheme.headlineLarge!.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textTheme.headlineLarge?.color,
      );

  TextStyle get heading2 => textTheme.headlineMedium!.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textTheme.headlineMedium?.color,
      );

  TextStyle get heading3 => textTheme.headlineSmall!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textTheme.headlineSmall?.color,
      );

  // Body text
  TextStyle get body => textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textTheme.bodyLarge?.color,
      );

  TextStyle get bodySecondary => textTheme.bodyMedium!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textTheme.bodyMedium?.color,
      );

  // Labels
  TextStyle get label => textTheme.labelMedium!.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textTheme.labelMedium?.color,
      );

  // Error
  TextStyle get error => textTheme.bodyMedium!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.error,
      );

  // Success (custom color, أو تقدر تعرف success في colorScheme)
  TextStyle get success => textTheme.bodyMedium!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.green, // تقدر تخليه dynamic لو عرفته في الثيم
      );

  // Button
  TextStyle get button => textTheme.labelLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      );

  // Subtitle
  TextStyle get subtitle => textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textTheme.titleMedium?.color,
      );
}

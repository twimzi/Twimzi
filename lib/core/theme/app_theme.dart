import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

class TwimziTheme {
  const TwimziTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: TwimziColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: TwimziColors.primary,
      brightness: Brightness.light,
    ),

    textTheme: const TextTheme(
      displayLarge: TwimziTypography.displayLarge,
      displayMedium: TwimziTypography.displayMedium,
      headlineLarge: TwimziTypography.headlineLarge,
      headlineMedium: TwimziTypography.headlineMedium,
      titleLarge: TwimziTypography.titleLarge,
      titleMedium: TwimziTypography.titleMedium,
      bodyLarge: TwimziTypography.bodyLarge,
      bodyMedium: TwimziTypography.bodyMedium,
      labelLarge: TwimziTypography.labelLarge,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: TwimziColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          TwimziRadius.lg,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          TwimziRadius.md,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          TwimziRadius.md,
        ),
        borderSide: const BorderSide(
          color: TwimziColors.border,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          TwimziRadius.md,
        ),
        borderSide: const BorderSide(
          color: TwimziColors.primary,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          56,
        ),
        backgroundColor: TwimziColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            TwimziRadius.md,
          ),
        ),
      ),
    ),
  );
}
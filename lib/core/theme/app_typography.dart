import 'package:flutter/material.dart';

import 'app_colors.dart';

class TwimziTypography {
  const TwimziTypography._();

  static const fontFamily = 'Roboto';

  static const displayLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: TwimziColors.textPrimary,
  );

  static const displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: TwimziColors.textPrimary,
  );

  static const headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: TwimziColors.textPrimary,
  );

  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: TwimziColors.textPrimary,
  );

  static const titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: TwimziColors.textPrimary,
  );

  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: TwimziColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: TwimziColors.textPrimary,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: TwimziColors.textSecondary,
  );

  static const labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
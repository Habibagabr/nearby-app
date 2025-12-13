import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles();

  // -------------------------------------------------------------
  // DISPLAY — Largest text; used for splash, marketing, onboarding
  // -------------------------------------------------------------
  static const TextStyle displayLarge = TextStyle(
    fontSize: 54,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // -------------------------------------------------------------
  // HEADLINES — Page or section titles (H1, H2, H3 equivalents)
  // -------------------------------------------------------------
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // -------------------------------------------------------------
  // TITLES — AppBar titles, card headers, small section titles
  // -------------------------------------------------------------
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // -------------------------------------------------------------
  // BODY — Paragraphs, descriptions, messages
  // -------------------------------------------------------------
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // -------------------------------------------------------------
  //  LABEL — Buttons, chips, tags, helper text (Small UI)
  // -------------------------------------------------------------
  static const TextStyle labelLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Errors
  static const TextStyle errorText = TextStyle(
    color: AppColors.error,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

}

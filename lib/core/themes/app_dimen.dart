import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._(); // prevent instantiation

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS  = 8.0;
  static const double spacingM  = 16.0; // the stander
  static const double spacingL  = 24.0;
  static const double spacingXL  = 42.0;
  static const double spacingXXL = 52.0;

  // Padding
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 48.0;

  // Radius
  static const double radiusXS = 6.0;
  static const double radiusS = 12.0;
  static const double radiusM = 16.0;
  static const double radiusL = 24.0;
  static const double radiusXL = 32.0;

  // Heights
  static const double minimumButtonSize = 48.0;

  // Icons
  static const double iconExtraSmall = 22.0;
  static const double iconSmall = 24.0;
  static const double iconMedium = 28.0;
  static const double iconLarge = 56.0;


  // --- Ready-to-use SizedBox (Vertical) ---
  static const vXs = SizedBox(height: spacingXS);
  static const vSm = SizedBox(height: spacingS);
  static const vMd = SizedBox(height: spacingM);
  static const vLg = SizedBox(height: spacingL);
  static const vXl = SizedBox(height: spacingXL);
  static const vXxl = SizedBox(height: spacingXXL);

  // --- Ready-to-use SizedBox (Horizontal) ---
  static const hXs = SizedBox(width: spacingXS);
  static const hSm = SizedBox(width: spacingS);
  static const hMd = SizedBox(width: spacingM);
  static const hLg = SizedBox(width: spacingL);
  static const hXl = SizedBox(width: spacingXL);
  static const hXxl = SizedBox(width: spacingXXL);


}

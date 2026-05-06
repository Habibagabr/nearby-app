import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_dimen.dart';
import '../themes/app_text_style.dart';


// FIXME: This logic is may be deleted soon
class AppInputFieldsTheme {
  AppInputFieldsTheme._();

  static final InputDecorationTheme inputDecorationTheme =
  InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkGray,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusL),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusL),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusL),
      borderSide: BorderSide.none,
    ),

    hintStyle: AppTextStyles.bodyLarge.copyWith(
      color: AppColors.darkGray,
    ),

    contentPadding: EdgeInsets.symmetric(
      horizontal: AppDimens.paddingM,
      vertical: AppDimens.paddingM,
    ),
  );
}

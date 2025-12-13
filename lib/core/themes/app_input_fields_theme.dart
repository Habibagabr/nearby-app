import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_style.dart';
import '../values/app_dimen.dart';

class AppInputFieldsTheme {
  AppInputFieldsTheme._();

  static final InputDecorationTheme inputDecorationTheme =
  InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkGray,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusM),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusM),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimens.radiusM),
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

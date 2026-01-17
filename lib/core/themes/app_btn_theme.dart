import 'app_colors.dart';
import '../values/app_dimen.dart';
import 'package:flutter/material.dart';

import 'app_text_style.dart';

class AppBtnTheme {
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGray,
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.labelMedium.copyWith(
            fontSize: 26
          ),
          padding: EdgeInsetsGeometry.symmetric(
              horizontal: AppDimens.paddingM ,
              vertical: AppDimens.paddingS
          ) ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  AppDimens.radiusM
              )
          )
      )
  );
}

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/pinicon.png',
              width: AppDimens.iconLarge,
            ),
            const SizedBox(height: AppDimens.spacingS),
            Text(
              AppLocalizations.of(context)!.appName,
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppDimens.spacingS),
            Text(
              AppLocalizations.of(context)!.splashTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppDimens.spacingM),
            const CircularProgressIndicator(color: AppColors.white),
          ],
        ),
    );
  }
}

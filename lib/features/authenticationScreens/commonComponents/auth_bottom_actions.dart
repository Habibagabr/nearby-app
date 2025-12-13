import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_text_style.dart';
import '../../../l10n/app_localizations.dart';
import '../utils/auth_screen_type.dart';

class AuthBottomActions extends StatelessWidget {
  final AuthScreenType screenType;
  final VoidCallback onPrimaryBtnPressed;
  final VoidCallback onSecondaryBtnPressed;

  const AuthBottomActions({
    super.key,
    required this.screenType,
    required this.onPrimaryBtnPressed,
    required this.onSecondaryBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final primaryText = switch (screenType) {
      AuthScreenType.login => local.login,
      AuthScreenType.signup => local.signup,
    };

    final secondaryText = switch (screenType) {
      AuthScreenType.login => local.signup,
      AuthScreenType.signup => local.login,
    };

    final secondaryHint = switch (screenType) {
      AuthScreenType.login => local.dontHaveAccount,
      AuthScreenType.signup => local.alreadyHaveAccount,
    };

    return Column(
      children: [
        // Primary Button
        SizedBox(
          width: 200,
          height: 48,
          child: ElevatedButton(
            onPressed: onPrimaryBtnPressed,
            child: Text(primaryText, style: AppTextStyles.labelMedium),
          ),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          // Bottom Text
          onTap: onSecondaryBtnPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(secondaryHint, style: AppTextStyles.bodyMedium),
              const SizedBox(width: 4),
              Text(
                secondaryText,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

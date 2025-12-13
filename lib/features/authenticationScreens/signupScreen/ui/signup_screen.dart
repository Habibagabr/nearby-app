// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/auth_field_type.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';
import 'package:near_buy_gp/shared/components/base_screen.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';

import '../../commonComponents/input_fields.dart';
import '../../commonComponents/auth_bottom_actions.dart';
import '../../../../shared/components/app_logo.dart';
import '../../utils/auth_screen_type.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;


    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Logo
          const Align(
            alignment: Alignment.topLeft,
            child: AppLogo(),
          ),
          SizedBox(height: AppDimens.spacingXL),

          /// Title
          Padding(
            padding: EdgeInsetsDirectional.only(start: AppDimens.paddingM),
            child: Text(
              local.signup,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),

          SizedBox(height: size.height * 0.03),
          Expanded(
            child:
            /// White Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimens.radiusL),
                ),
              ),
              padding: EdgeInsets.all(AppDimens.paddingM),
              child: ListView(
                children: [
                  InputField(
                    inputType: AuthFieldType.username,
                    label: local.usernameLabel,
                    hint: local.usernameHint,
                  ),

                  const SizedBox(height: AppDimens.spacingL),

                  InputField(
                    inputType: AuthFieldType.email,
                    label: local.emailLabel,
                    hint: local.emailHint,
                  ),

                  const SizedBox(height: AppDimens.spacingL),

                  InputField(
                    inputType: AuthFieldType.password,
                    label: local.passwordLabel,
                    hint: local.passwordHint,
                  ),

                  const SizedBox(height: AppDimens.spacingL),

                  InputField(
                    inputType: AuthFieldType.confirmPassword,
                    label: local.confirmPasswordLabel,
                    hint: local.confirmPasswordHint,
                  ),

                  const SizedBox(height: AppDimens.spacingL),

                  AuthBottomActions(
                    screenType: AuthScreenType.signup,
                    onPrimaryBtnPressed: () {},
                    onSecondaryBtnPressed: () {
                      // navigate to login
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/bloc/login_screen_bloc.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';
import 'package:near_buy_gp/shared/components/base_screen.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';

import '../../commonComponents/input_fields.dart';
import '../../commonComponents/auth_bottom_actions.dart';
import '../../../../shared/components/app_logo.dart';
import '../../signupScreen/ui/signup_screen.dart';
import '../../utils/auth_field_type.dart';
import '../../utils/auth_screen_type.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return BlocProvider<LoginScreenBloc>(
      create: (_) => LoginScreenBloc(),
      child: BlocListener<LoginScreenBloc, LoginScreenState>(
        listener: (context, state) {
          if (state is NavigateToSignupScreen) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SignupScreen(),
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            final bloc = context.read<LoginScreenBloc>();

            return BaseScreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  const Align(
                    alignment: Alignment.topLeft,
                    child: AppLogo(),
                  ),

                  SizedBox(height: size.height / 4),

                  /// Title
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppDimens.paddingM,
                    ),
                    child: Text(
                      local.login,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  /// White Card
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppDimens.radiusL),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.paddingM,
                        vertical: AppDimens.paddingM,
                      ),
                      child: ListView(
                        children: [
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

                          SizedBox(height: size.height * 0.03),

                          AuthBottomActions(
                            screenType: AuthScreenType.login,
                            onPrimaryBtnPressed: () {
                              // later: login validation
                            },
                            onSecondaryBtnPressed: () {
                              bloc.add(SecondaryBtnClicked());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

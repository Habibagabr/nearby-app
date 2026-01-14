// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/routing/app_routes.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/auth_field_type.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/input_fields_mapper.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';
import 'package:near_buy_gp/shared/components/base_screen.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../shared/components/app_logo.dart';
import '../../../commonWidgets/auth_bottom_actions.dart';
import '../../../commonWidgets/input_fields.dart';
import '../../../utils/auth_screen_type.dart';
import '../bloc/signup_screen_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupScreenBloc>(
      create: (_) => getIt<SignupScreenBloc>(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery
        .of(context)
        .size;


    return BlocListener<SignupScreenBloc, SignupScreenState>(
        listener: (context, state) {
          // handle signup failure (server/domain error)
          if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.failureMsg}"),
              ),
            );
          }

          // Existing logic (unchanged)
          if (state is NavigateToLoginScreen) {
            LoginRoute().go(context);
          }
        },
        child: BaseScreen(
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
                    padding:
                    EdgeInsetsDirectional.only(start: AppDimens.paddingM),
                    child: Text(
                      local.signup,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppDimens.radiusL),
                          ),
                        ),
                        padding: EdgeInsets.all(AppDimens.paddingM),
                        child: BlocBuilder<SignupScreenBloc, SignupScreenState>(
                          builder: (BuildContext context, state) {
                            String? emailErrorKey;
                            String? userNameErrorKey;
                            String? passwordErrorKey;
                            String? confirmPasswordErrorKey;

                            if (state is SignupValidationError) {
                              emailErrorKey =
                                  state.emailError?.localizationKey;
                              userNameErrorKey =
                                  state.userNameError?.localizationKey;
                              passwordErrorKey =
                                  state.passwordError?.localizationKey;
                              confirmPasswordErrorKey =
                                  state.confirmPasswordError?.localizationKey;
                            }
                            final isLoading = state is SignupLoading;

                            return ListView(
                              children: [
                                InputField(
                                  inputType: AuthFieldType.username,
                                  label: local.usernameLabel,
                                  hint: local.usernameHint,
                                  controller: _userNameController,
                                  isError: userNameErrorKey != null,
                                  // null-safe translate
                                  errorMessage: userNameErrorKey != null
                                      ? local.translate(userNameErrorKey)
                                      : null,
                                ),

                                const SizedBox(height: AppDimens.spacingL),

                                InputField(
                                  inputType: AuthFieldType.email,
                                  label: local.emailLabel,
                                  hint: local.emailHint,
                                  controller: _emailController,
                                  isError: emailErrorKey != null,
                                  errorMessage: emailErrorKey != null
                                      ? local.translate(emailErrorKey)
                                      : null,
                                ),

                                const SizedBox(height: AppDimens.spacingL),

                                InputField(
                                  inputType: AuthFieldType.password,
                                  label: local.passwordLabel,
                                  hint: local.passwordHint,
                                  controller: _passwordController,
                                  isError: passwordErrorKey != null,
                                  errorMessage: passwordErrorKey != null
                                      ? local.translate(passwordErrorKey)
                                      : null,
                                ),

                                const SizedBox(height: AppDimens.spacingL),

                                InputField(
                                  inputType: AuthFieldType.confirmPassword,
                                  label: local.confirmPasswordLabel,
                                  hint: local.confirmPasswordHint,
                                  controller: _confirmPasswordController,
                                  isError: confirmPasswordErrorKey != null,
                                  errorMessage: confirmPasswordErrorKey != null
                                      ? local.translate(confirmPasswordErrorKey)
                                      : null,
                                ),

                                const SizedBox(height: AppDimens.spacingL),

                                AuthBottomActions(
                                  screenType: AuthScreenType.signup,
                                  onPrimaryBtnPressed: () {
                                    context
                                        .read<SignupScreenBloc>()
                                        .add(
                                      PrimaryBtnClicked(
                                        email:
                                        _emailController.text,
                                        password:
                                        _passwordController.text,
                                        userName:
                                        _userNameController.text,
                                        confirmPassword:
                                        _confirmPasswordController
                                            .text,
                                      ),
                                    );
                                  },
                                  onSecondaryBtnPressed: () {
                                    context
                                        .read<SignupScreenBloc>()
                                        .add(SecondaryBtnClicked());
                                  },
                                ),
                                Visibility(
                                  visible: isLoading,
                                  child: Positioned.fill(
                                    child: const Align(
                                      alignment: Alignment.bottomCenter,
                                      // NOT centered
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: CircularProgressIndicator(
                                          color:AppColors.darkGray ,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                  )
                ]
            )
        )
    );
  }
}

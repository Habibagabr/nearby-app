import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/routing/app_routes.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/input_fields_mapper.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';

import '../../../../../core/common_widgets/popup_component.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../shared/components/app_logo.dart';
import '../../../../../shared/components/auth_base_screen.dart';
import '../../../commonWidgets/auth_bottom_actions.dart';
import '../../../commonWidgets/input_fields.dart';
import '../../../utils/auth_field_type.dart';
import '../../../utils/auth_screen_type.dart';
import '../bloc/login_screen_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginScreenBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final bloc = context.read<LoginScreenBloc>();

    return BlocListener<LoginScreenBloc, LoginScreenState> (
      listener: (context, state) async{
        if (state is NavigateToSignupScreen) {
          SignupRoute().go(context);
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${state.errorMsg}")));
        }
        else if (state is LoginSuccess)  {
          appPopup(context: context, icon: Icons.done_sharp, title: "You Login Successfully");
          await Future.delayed(
              const Duration(milliseconds: 2000)
          );
          if (context.mounted) {
            Navigator.of(context).pop();
            context.go(MainShellRoute().location);
          }
        }
      },
      child: AuthBaseScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: AppLogo(AppColors.white),
            ),

            SizedBox(height: size.height / 4),

            Padding(
              padding: EdgeInsetsDirectional.only(start: AppDimens.paddingM),
              child: Text(
                local.login,
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
                padding: const EdgeInsets.all(AppDimens.paddingM),
                child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
                  builder: (context, state) {
                    String? emailErrorKey;
                    String? passwordErrorKey;

                    if (state is LoginValidationError) {
                      emailErrorKey = state.emailError?.localizationKey;
                      passwordErrorKey = state.passwordError?.localizationKey;
                    }
                    final isLoading = state is LoginLoading;

                    return ListView(
                      children: [
                        InputField(
                          inputType: AuthFieldType.email,
                          label: local.emailLabel,
                          hint: local.emailHint,
                          controller: _emailController,
                          isError: emailErrorKey != null,
                          errorMessage: emailErrorKey != null
                              ? AppLocalizations.of(
                                  context,
                                )!.translate(emailErrorKey)
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
                              ? AppLocalizations.of(
                                  context,
                                )!.translate(passwordErrorKey)
                              : null,
                        ),

                        SizedBox(height: size.height * 0.03),

                        AuthBottomActions(
                          screenType: AuthScreenType.login,
                          onPrimaryBtnPressed: () {
                            bloc.add(
                              PrimaryBtnClicked(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          onSecondaryBtnPressed: () {
                            bloc.add(SecondaryBtnClicked());
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
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

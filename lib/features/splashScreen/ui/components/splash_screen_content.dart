import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/routing/app_routes.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';
import 'package:near_buy_gp/l10n/app_localizations.dart';
import 'package:near_buy_gp/features/splashScreen/bloc/splash_screen_bloc.dart';

import '../../../authenticationScreens/loginScreen/ui/login_screen.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenBloc()..add(SplashScreenStarted()),
      child: BlocConsumer<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is NavigateToLogin) {
            LoginRoute().go(context);

          }
        },
        builder: (context, state) {
          final isLoading = state is SplashScreenLoading;

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Logo
                Image(
                  image: const AssetImage("assets/images/pinicon.png"),
                  width: AppDimens.iconLarge,
                ),

                const SizedBox(height: AppDimens.spacingS),

                /// App Name
                Text(
                  AppLocalizations.of(context)!.appName,
                  style: AppTextStyles.displayLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: AppDimens.spacingS),

                /// Slogan
                Text(
                  AppLocalizations.of(context)!.splashTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),

                /// Loader
                if (isLoading) ...[
                  const SizedBox(height: AppDimens.spacingM),
                  CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

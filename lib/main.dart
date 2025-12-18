import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/routing/app_router.dart';
import 'package:near_buy_gp/features/splashScreen/splash_screen.dart';

import 'core/themes/app_btn_theme.dart';
import 'core/themes/app_colors.dart';
import 'core/themes/app_input_fields_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(NearBuy());
}

class NearBuy extends StatelessWidget {
  const NearBuy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,


      // dictionary
      localizationsDelegates: const [
        AppLocalizations.delegate, // my dictionary
        GlobalMaterialLocalizations.delegate, // material dictionary
        GlobalWidgetsLocalizations.delegate, // LRT , RLT
        GlobalCupertinoLocalizations.delegate, // for ios
      ],

      supportedLocales: const [Locale('en'), Locale('ar')],
      theme: ThemeData(
        elevatedButtonTheme: AppBtnTheme.elevatedButtonTheme,
        inputDecorationTheme: AppInputFieldsTheme.inputDecorationTheme,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.white,
        ),

      ),
        routerConfig:appRouter
    );
  }
}

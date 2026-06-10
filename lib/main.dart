import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/bloc/profile_bloc.dart';
import 'package:near_buy_gp/features/splashScreen/bloc/splash_screen_bloc.dart';

import 'core/di/injection.dart';
import 'core/location/presentation/bloc/location_bloc.dart';
import 'core/routing/app_router.dart';
import 'core/themes/app_colors.dart';
import 'core/common_widgets/app_input_fields_theme.dart';
import 'features/mapScreen/presentation/bloc/map_bloc.dart';
import 'features/onboardingScreens/main_onboarding.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const NearBuy());
}

class NearBuy extends StatelessWidget {
  const NearBuy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ///  Location Bloc (Global)
        BlocProvider<LocationBloc>(
          create: (_) => getIt<LocationBloc>(),
        ),
        ///  map Bloc (Global)
        BlocProvider<MapBloc>(
          create: (_) => getIt<MapBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => getIt<HomeBloc>(),
        ),

        BlocProvider<SplashScreenBloc>(
          create: (_) => SplashScreenBloc(),
        ),

        BlocProvider<ProfileBloc>(
          create: (_) =>
          getIt<ProfileBloc>()
            ..add(ProfileScreenStarted()), // will be changed
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //  Localization
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],

        //  Theme
        theme: ThemeData(
          inputDecorationTheme: AppInputFieldsTheme.inputDecorationTheme,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.white,
          ),
        ),

        //  Router
        // routerConfig: appRouter,
        home: MainOnboarding(),

      ),
    );
  }
}

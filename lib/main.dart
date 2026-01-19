import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/themes/app_btn_theme.dart';
import 'core/themes/app_colors.dart';
import 'core/themes/app_input_fields_theme.dart';
import 'features/homeScreen/ui/home_screen.dart';
import 'l10n/app_localizations.dart';

//  blocs
import 'features/location/presentation/bloc/location_bloc.dart';

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
          create: (_) => LocationBloc()..add(StartLocationTracking())
        ),
      ],
      child: MaterialApp.router(
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
          elevatedButtonTheme: AppBtnTheme.elevatedButtonTheme,
          inputDecorationTheme: AppInputFieldsTheme.inputDecorationTheme,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.white,
          ),
        ),

        //  Router
        routerConfig: appRouter,

      ),
    );
  }
}

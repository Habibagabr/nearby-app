import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:near_buy_gp/features/place_screen/presentation/place_base_screen.dart';

import 'core/di/injection.dart';
import 'core/location/presentation/bloc/location_bloc.dart';
import 'core/themes/app_btn_theme.dart';
import 'core/themes/app_colors.dart';
import 'core/themes/app_input_fields_theme.dart';
import 'features/mapScreen/presentation/bloc/map_bloc.dart';
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
        BlocProvider<MapBloc>(
          create: (_) => getIt<MapBloc>(),
        )
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
          elevatedButtonTheme: AppBtnTheme.elevatedButtonTheme,
          inputDecorationTheme: AppInputFieldsTheme.inputDecorationTheme,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.white,
          ),
        ),

        //  Router
        // routerConfig: appRouter,
        home: PlaceBaseScreen(),

      ),
    );
  }
}

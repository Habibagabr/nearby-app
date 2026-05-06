import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/routing/app_routes.dart';
import 'package:near_buy_gp/features/splashScreen/ui/components/splash_screen_content.dart';
import 'package:near_buy_gp/shared/components/auth_base_screen.dart';

import '../../core/location/presentation/bloc/location_bloc.dart';
import '../../core/location/presentation/bloc/location_event.dart';
import '../../core/location/presentation/bloc/location_state.dart';
import 'bloc/splash_screen_bloc.dart';

import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    context.read<SplashScreenBloc>().add(SplashScreenStarted());
  }

  void _requestLocationPermission() {
    context.read<LocationBloc>().add(RequestPermission());
  }

  void _navigateHome(BuildContext context) {
    if (_navigated) return;
    _navigated = true;
    context.go(MainShellRoute().location);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// Splash finished
        BlocListener<SplashScreenBloc, SplashScreenState>(
          listener: (context, state) async {
            if (state is SplashScreenReady) {
              if(kDebugMode){
                print("PRINT : the splash screen is ready and we go to the location request");
              }
              _requestLocationPermission();

            }
          },
        ),

        /// Location handling
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.status == LocationStatus.initial ||
                state.status == LocationStatus.loading) {
              return;
            }

            if (state.status == LocationStatus.tracking &&
                state.location != null) {
              context.read<HomeBloc>().add(
                FetchNearbyPlacesEvent(
                  lat: state.location!.latitude,
                  lng: state.location!.longitude,
                  pageNum: 1,
                  limit: 10,
                ),
              );
              if(kDebugMode){
                print("PRINT location 1 : the location request is : ${state.status}");
              }

              _navigateHome(context);
              return;
            }
            if(kDebugMode){
              print("PRINT location 2 : the location request is : ${state.status}");
            }

            // denied / disabled
            _navigateHome(context);

          },
        ),
      ],
      child: const Scaffold(
        extendBodyBehindAppBar: true,
        body: AuthBaseScreen(child: SplashScreenContent()),
      ),
    );
  }
}

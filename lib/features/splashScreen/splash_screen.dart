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
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    //  Safely trigger the startup event right when the widget initializes
    context.read<SplashScreenBloc>().add(SplashScreenStarted());
  }


  void _safeNavigate(String targetRoute) {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);
    context.go(targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashScreenBloc, SplashScreenState>(
          listener: (context, state) {
            if (state is NavigateToOnBoarding) {

              _safeNavigate(OnBoardingScreenRoute().location);
            }
            else if (state is CheckLocationPermissionBeforeHome) {
              context.read<LocationBloc>().add(RequestPermission());
            }
          },
        ),

        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.status == LocationStatus.initial || state.status == LocationStatus.loading) {
              return;
            }

            if (state.status == LocationStatus.tracking && state.location != null) {
              context.read<HomeBloc>().add(
                FetchNearbyPlacesEvent(
                  lat: state.location!.latitude,
                  lng: state.location!.longitude,
                  pageNum: 1,
                  limit: 3,
                ),
              );
            }

            _safeNavigate(MainShellRoute().location);
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

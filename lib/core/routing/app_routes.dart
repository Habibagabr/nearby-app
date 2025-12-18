import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/ui/login_screen.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/ui/signup_screen.dart';

import '../../features/splashScreen/splash_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
)
// Added "with _$SplashRoute"
class SplashRoute extends GoRouteData with _$SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
// Added "with _$LoginRoute"
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<SignupRoute>(
  path: '/signup',
)
// Added "with _$SignupRoute"
class SignupRoute extends GoRouteData with _$SignupRoute {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupScreen();
  }
}

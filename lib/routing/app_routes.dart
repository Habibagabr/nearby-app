import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splashScreen/splash_screen.dart';
import '../features/authenticationScreens/loginScreen/ui/login_screen.dart';
import '../features/authenticationScreens/signupScreen/ui/signup_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<RootRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SplashRoute>(
      path: 'splash',
    ),
    TypedGoRoute<LoginRoute>(
      path: 'login',
    ),
    TypedGoRoute<SignupRoute>(
      path: 'signup',
    ),
  ],
)
class RootRoute extends GoRouteData {
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Root مش بيظهر
    return const SizedBox.shrink();
  }
}

class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupScreen();
  }
}

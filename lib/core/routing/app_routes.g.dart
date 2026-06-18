// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $personalizedScreenRoute,
  $onBoardingScreenRoute,
  $splashRoute,
  $loginRoute,
  $signupRoute,
  $mainShellRoute,
  $placeDetailsRoute,
  $notificationScreenRoute,
];

RouteBase get $personalizedScreenRoute => GoRouteData.$route(
  path: '/personalizedScreen',

  factory: _$PersonalizedScreenRoute._fromState,
);

mixin _$PersonalizedScreenRoute on GoRouteData {
  static PersonalizedScreenRoute _fromState(GoRouterState state) =>
      const PersonalizedScreenRoute();

  @override
  String get location => GoRouteData.$location('/personalizedScreen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onBoardingScreenRoute => GoRouteData.$route(
  path: '/onBoardingScreen',

  factory: _$OnBoardingScreenRoute._fromState,
);

mixin _$OnBoardingScreenRoute on GoRouteData {
  static OnBoardingScreenRoute _fromState(GoRouterState state) =>
      const OnBoardingScreenRoute();

  @override
  String get location => GoRouteData.$location('/onBoardingScreen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: _$SplashRoute._fromState);

mixin _$SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: _$LoginRoute._fromState);

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute =>
    GoRouteData.$route(path: '/signup', factory: _$SignupRoute._fromState);

mixin _$SignupRoute on GoRouteData {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRoute =>
    GoRouteData.$route(path: '/main', factory: _$MainShellRoute._fromState);

mixin _$MainShellRoute on GoRouteData {
  static MainShellRoute _fromState(GoRouterState state) => MainShellRoute();

  @override
  String get location => GoRouteData.$location('/main');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $placeDetailsRoute => GoRouteData.$route(
  path: '/details/:placeId',

  factory: _$PlaceDetailsRoute._fromState,
);

mixin _$PlaceDetailsRoute on GoRouteData {
  static PlaceDetailsRoute _fromState(GoRouterState state) => PlaceDetailsRoute(
    placeId: state.pathParameters['placeId']!,
    screensType: _$ScreensTypeEnumMap._$fromName(
      state.uri.queryParameters['screens-type']!,
    )!,
  );

  PlaceDetailsRoute get _self => this as PlaceDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/details/${Uri.encodeComponent(_self.placeId)}',
    queryParams: {'screens-type': _$ScreensTypeEnumMap[_self.screensType]},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$ScreensTypeEnumMap = {
  ScreensType.store: 'store',
  ScreensType.clinic: 'clinic',
  ScreensType.generic: 'generic',
  ScreensType.gym: 'gym',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}

RouteBase get $notificationScreenRoute => GoRouteData.$route(
  path: '/notification',

  factory: _$NotificationScreenRoute._fromState,
);

mixin _$NotificationScreenRoute on GoRouteData {
  static NotificationScreenRoute _fromState(GoRouterState state) =>
      NotificationScreenRoute();

  @override
  String get location => GoRouteData.$location('/notification');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

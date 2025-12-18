import 'package:go_router/go_router.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: const SplashRoute().location,
  routes: $appRoutes,
);

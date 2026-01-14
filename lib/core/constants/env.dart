abstract class Env {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://nearbuy-service-api-env.up.railway.app',
  );
}

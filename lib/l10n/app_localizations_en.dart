// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NearBuy';

  @override
  String get splashTitle => 'Scan the world, watch it come alive';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Signup';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get usernameLabel => 'Username';

  @override
  String get dontHaveAccount => 'Don’t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';
}

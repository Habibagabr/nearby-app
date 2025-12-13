// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'NearBuy';

  @override
  String get splashTitle => 'استكشف العالم، وشاهده ينبض بالحياة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'انشاء حساب';

  @override
  String get emailHint => 'ادخل حسابك';

  @override
  String get emailLabel => 'حسابك';

  @override
  String get passwordHint => 'ادخل كلمة السر الخاصه بك';

  @override
  String get passwordLabel => 'رقمك السري';

  @override
  String get confirmPasswordHint => 'اعد كتابة كلمة السر الخاصه بك مره اخرى';

  @override
  String get confirmPasswordLabel => 'كلمة السر مرة اخرى';

  @override
  String get usernameHint => 'ادخل اسم المستخدم الخاص بك';

  @override
  String get usernameLabel => 'اسم المستخدم';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';
}

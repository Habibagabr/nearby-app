import '../../../l10n/app_localizations.dart';

extension AppLocalizationsMapper on AppLocalizations {
  String? translate(String? key) {
    if (key == null) return null;
    return switch (key) {
      "weakPassword" => weakPassword,
      "unmatchedPassword" => unmatchedPassword,
      "invalidEmail" => invalidEmail,
      "emptyFields" => emptyFields,
      String() => throw UnimplementedError(),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';

import '../../core/themes/app_text_style.dart';
import '../../l10n/app_localizations.dart';

class AppLogo extends StatelessWidget {
  final Color logoColor;
  const AppLogo(this.logoColor, {super.key});


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(left: AppDimens.paddingS ,bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/pinicon.png",
              width: AppDimens.iconSmall,
            ),
            SizedBox(width: AppDimens.spacingS),
            Text(
              AppLocalizations.of(context)!.appName,
              style: AppTextStyles.headlineMedium.copyWith(
                color: logoColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';

class PersonalizedScreenSection extends StatelessWidget {
  final String headerTitle;
  final String subHeader;
  final Widget bodyContent;

  const PersonalizedScreenSection({
    super.key,
    required this.bodyContent,
    required this.headerTitle,
    required this.subHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimens.spacingS,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerTitle,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          subHeader,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        bodyContent
      ],
    );
  }
}

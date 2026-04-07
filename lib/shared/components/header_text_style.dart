import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

import '../../core/themes/app_text_style.dart';

class HeaderText extends StatelessWidget{
  final String headerTitle;
  final Color? textColor;

  const HeaderText(this.headerTitle,{super.key , this.textColor} );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          headerTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            color: textColor ?? AppColors.white
          ),

        )
      ],
    );
  }

}
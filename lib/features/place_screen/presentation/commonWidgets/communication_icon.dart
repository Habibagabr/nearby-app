import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class CommunicationIcon extends StatelessWidget {
  final Widget iconImage;
  final Function() onIconPressed;
  final String iconName;

  const CommunicationIcon({
    super.key,
    required this.iconImage,
    required this.onIconPressed,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onIconPressed,
          icon: iconImage,
          style: IconButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.darkGray,
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          iconName,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: AppColors.darkGray.withAlpha(225),
          ),

        )
      ],
    );
  }
}

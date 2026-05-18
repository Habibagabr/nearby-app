import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class ServicesHeader extends StatelessWidget {
  final String headerText;
  final Icon? icon;

  const ServicesHeader({super.key, required this.headerText, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Expanded(
          child: Text(
            headerText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.darkGray,
            ),
          ),
        ),
      ],
    );
  }
}

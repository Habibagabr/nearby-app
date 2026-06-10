import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class UserPersonalizedOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final IconData? optionIcon;

  const UserPersonalizedOption({
    super.key,
    required this.option,
    required this.isSelected,
    this.optionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.orange.withAlpha(200) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.orange.withAlpha(200) : AppColors.white,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(optionIcon, size: 16, color: AppColors.white),
          const SizedBox(width: 6),
          Text(
            option,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

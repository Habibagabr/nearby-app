import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class AppButton extends StatelessWidget {
  final String buttonActionTitle;
  final VoidCallback onButtonPressed;
  final Color backgroundColor;
  final Color textColor;

  const AppButton({
    super.key,
    required this.buttonActionTitle,
    required this.onButtonPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: AppColors.darkGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onButtonPressed,
      child: Text(
        buttonActionTitle,
        style: TextStyle(
          color: AppColors.darkGray,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

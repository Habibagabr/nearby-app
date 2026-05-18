import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final double switchTrackingWidth;
  final double switchTrackingHeight;
  final double switchBallSize;
  final VoidCallback onChange; // Changed to VoidCallback to let parent handle evaluation
  final bool isSwitchOn;

  const CustomSwitch({
    super.key,
    required this.switchTrackingWidth,
    required this.isSwitchOn,
    required this.switchTrackingHeight,
    required this.switchBallSize,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange, // Directly pass click event up
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: switchTrackingWidth,
        height: switchTrackingHeight,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSwitchOn ? AppColors.darkGray : const Color(0xFFD1D5DB),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          alignment: isSwitchOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: switchBallSize,
            height: switchBallSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

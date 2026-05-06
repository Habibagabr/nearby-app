import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class CustomSwitch extends StatefulWidget {
  final double? switchTrackingWidth;
  final double? switchTrackingHeight;
  final double? switchBallSize;
  final ValueChanged<bool>? onTurnedOn;
  const CustomSwitch({super.key , required this.switchTrackingWidth , required this.switchTrackingHeight , required this.switchBallSize , this.onTurnedOn});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
        widget.onTurnedOn?.call(isOn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: widget.switchTrackingWidth,
        height: widget.switchTrackingHeight,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isOn ? AppColors.darkGray : const Color(0xFFD1D5DB),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          alignment:
          isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: widget.switchBallSize,
            height: widget.switchBallSize,
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
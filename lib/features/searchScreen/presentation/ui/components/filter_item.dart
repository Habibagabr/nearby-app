import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class FilterItem extends StatelessWidget {
  final Widget filterValue;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterItem({
    super.key,
    required this.filterValue,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor =
    isSelected ? Colors.white : const Color(0XFF364153);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? Colors.transparent
                : const Color(0XFFE5E7EB),
          ),
        ),
        color: isSelected
            ?  AppColors.darkGray
            : const Color(0XFFF3F4F6),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(color: contentColor),
            child: DefaultTextStyle(
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.bold,
              ),
              child: filterValue,
            ),
          ),
        ),
      ),
    );
  }
}
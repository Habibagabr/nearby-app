import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsGeometry.directional(end: 12, start: 4),
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkGray : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              categoryIcon,
              color: isSelected
                  ? AppColors.white
                  : AppColors.white.withAlpha(150),
            ),
            Text(
              categoryName,
              style: TextStyle(
                color: isSelected
                    ? AppColors.white
                    : AppColors.white.withAlpha(150),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class DataCard extends StatelessWidget {
  final IconData icon;
  final String cardTitle;
  final String? cardSubTitle;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? titleColor;
  final double? topRight;
  final double? topLeft;
  final double? bottomRight;
  final double? bottomLeft;
  final VoidCallback? onCardClicked;
  final Widget? actionWidget;

  const DataCard({
    super.key,
    required this.icon,
    this.bottomRight,
    this.bottomLeft,
    this.topLeft,
    this.topRight,
    this.iconColor,
    this.titleColor,
    required this.cardTitle,
     this.cardSubTitle,
    this.iconBackgroundColor,
    this.onCardClicked,
    this.actionWidget

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardClicked,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: topLeft != null
                ? Radius.circular(topLeft!)
                : Radius.circular(0),
            topRight: topRight != null
                ? Radius.circular(topRight!)
                : Radius.circular(0),
            bottomLeft: bottomLeft != null
                ? Radius.circular(bottomLeft!)
                : Radius.circular(0),
            bottomRight: bottomRight != null
                ? Radius.circular(bottomRight!)
                : Radius.circular(0),
          ),
          border: Border.all(
            color: AppColors.darkGray.withAlpha(50),
            width: 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 12,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        iconBackgroundColor ?? AppColors.darkGray.withAlpha(20),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.darkGray.withAlpha(100),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: titleColor ?? AppColors.darkGray,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    if(cardSubTitle != null)
                    Text(
                      cardSubTitle!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.darkGray.withAlpha(150),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: actionWidget,
            ),
          ],
        ),
      ),
    );
  }
}

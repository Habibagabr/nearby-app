import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

Future<void> appPopup({
  required BuildContext context,
   IconData ? icon,
   String? title,
  String ? bodyContent,
   String? confirmActionTitle,
   String ? dismissActionTitle,
   VoidCallback ? onConfirmPressed,
}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.darkGray,
        contentTextStyle: const TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: ColoredBox(
          color: AppColors.darkGray,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 24,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  Icon(icon, size: 40, color: AppColors.white),
                  Expanded(
                    child: Text(
                      title ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              if(bodyContent != null)
              Text(bodyContent, textAlign: TextAlign.start),
              if(dismissActionTitle !=null && confirmActionTitle !=null)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 12,
                children: [
                  if(dismissActionTitle != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.darkGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      dismissActionTitle,
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if(confirmActionTitle != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.darkGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirmPressed!();
                    },
                    child: Text(
                      confirmActionTitle,
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

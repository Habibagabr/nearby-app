import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class PlacesTopBar extends StatelessWidget{
  // final String placeId;
  const PlacesTopBar({super.key });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 10 , right: 10, top:40),
      child:Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
        style: IconButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.darkGray,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark),
              style: IconButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.darkGray,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(width: 4),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              style: IconButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.darkGray,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

          ],
        )

      ]
    )
    );
  }

}
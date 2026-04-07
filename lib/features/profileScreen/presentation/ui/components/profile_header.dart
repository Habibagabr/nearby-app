import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

import '../../../../../core/ui/app_buttons.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 60),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // profile image
            Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Center(
                child: Icon(Icons.person, color: Colors.black, size: 75),
              ),
            ),
            SizedBox(height: 22),
            Text(
              "Nearby Team ",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "NearbyTeam@gmail.com",
              style: TextStyle(
                color: AppColors.white.withAlpha(200),
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            AppButton(
              textColor: Color(0XFF1D1D1D),
              backgroundColor: Colors.white,
              buttonActionTitle: "Edit your Profile",
              onButtonPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../../../../core/routing/app_routes.dart";
import "../../../../core/themes/app_colors.dart";
import "../../../../shared/components/app_logo.dart";

class HomeScreenHeader extends StatelessWidget{
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.only(top: 36, left: 12, right: 6),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.darkGray),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLogo(AppColors.white),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){
              NotificationScreenRoute().push(context);
            },
            color: AppColors.white,
            iconSize: 32,
          ),
        ],
      ),
    );

  }

}
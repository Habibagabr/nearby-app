import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/switch.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../shared/components/header_text_style.dart';
import '../common/data_card.dart';

class PreferenceManaging extends StatelessWidget {
  const PreferenceManaging({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          HeaderText("Preferences", textColor: AppColors.darkGray),
          SizedBox(height: 20),
          DataCard(
            cardTitle: "Notification",
            icon: Icons.notifications,
            topRight: 24,
            topLeft: 24,
            actionWidget: CustomSwitch(
              switchTrackingWidth: 60,
              switchTrackingHeight: 28,
              switchBallSize: 24,
            ),
          ),
          DataCard(
            cardSubTitle: "Set default location",
            cardTitle: "Location",
            icon: Icons.location_on_sharp,
            actionWidget: Icon(
              Icons.navigate_next_outlined,
              color: AppColors.darkGray.withAlpha(100),
            ),
          ),
          DataCard(
            cardTitle: "Language",
            cardSubTitle: "English",
            icon: Icons.language_outlined,
            actionWidget: Icon(
              Icons.navigate_next_outlined,
              color: AppColors.darkGray.withAlpha(100),
            ),
            onCardClicked: () {},
          ),
          DataCard(
            cardTitle: "Dark Mode",
            icon: Icons.palette_outlined,
            bottomLeft: 24,
            bottomRight: 24,
            actionWidget: CustomSwitch(
              switchTrackingWidth: 60,
              switchTrackingHeight: 28,
              switchBallSize: 24,
            ),
            onCardClicked: () {},
          ),


        ],
      ),
    );
  }
}

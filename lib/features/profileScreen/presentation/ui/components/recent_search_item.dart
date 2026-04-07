import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class RecentSearchItem extends StatelessWidget {
  final String recentSearch;
  const RecentSearchItem({super.key, required this.recentSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.darkGray.withAlpha(50), width: 1),
      ),
      child: Row(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkGray.withAlpha(20),
            ),
            child: Center(
              child: Icon(
                Icons.watch_later_outlined,
                color: AppColors.darkGray.withAlpha(100),
              ),
            ),
          ),
          Text(
            recentSearch,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class SavedPlacesSkeleton extends StatelessWidget {
  const SavedPlacesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      child: Column(
        children: [

          /// Header Skeleton
          Skeletonizer(
            enabled: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 140,
                  color: AppColors.darkGray,
                ),
                Container(
                  height: 20,
                  width: 80,
                  color: AppColors.darkGray,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Grid Skeleton
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.60,
            ),
            itemCount: 6, // fake loading items
            itemBuilder: (context, index) =>
            const SavedPlaceItemSkeleton(),
          ),
        ],
      ),
    );
  }
}

class SavedPlaceItemSkeleton extends StatelessWidget {
  const SavedPlaceItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.withAlpha(50),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            /// Image Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),

            const SizedBox(height: 12),

            /// Title
            Container(
              height: 14,
              width: 90,
              color: Colors.grey.shade300,
            ),

            const SizedBox(height: 6),

            /// Subtitle
            Container(
              height: 12,
              width: 60,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
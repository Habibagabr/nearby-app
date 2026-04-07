import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/themes/app_colors.dart';

class RecentlySearchSkeleton extends StatelessWidget {
  const RecentlySearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {

          /// Header Skeleton
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 14),
              child: Skeletonizer(
                enabled: true,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      width: 150,
                      color: AppColors.darkGray,
                    ),
                    Container(
                      height: 20,
                      width: 60,
                      color: AppColors.darkGray,
                    ),
                  ],
                ),
              ),
            );
          }

          /// List Item Skeleton
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Skeletonizer(
              enabled: true,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        },
        childCount: 6, // 1 header + 5 fake items
      ),
    );
  }
}
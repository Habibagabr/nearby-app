import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
        decoration: const BoxDecoration(
          color: AppColors.darkGray,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Center(
          child: Column(
            children: [

              /// Profile Image Skeleton
              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 22),

              /// Username Skeleton
              Container(
                height: 18,
                width: 180,
                color: Colors.white,
              ),

              const SizedBox(height: 12),

              /// Email Skeleton
              Container(
                height: 18,
                width: 220,
                color: Colors.white,
              ),

              const SizedBox(height: 20),

              /// Button Skeleton
              Container(
                height: 45,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
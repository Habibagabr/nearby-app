import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClinicMainSkeleton extends StatelessWidget {
  const ClinicMainSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        /// Image skeleton
        SliverToBoxAdapter(
          child: const SkeletonBox(
            height: 300,
            width: double.infinity,
            borderRadius: 0,
          ),
        ),

        /// Description skeleton
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(height: 20, width: 200),
                SizedBox(height: 10),
                SkeletonBox(height: 14, width: double.infinity),
                SizedBox(height: 6),
                SkeletonBox(height: 14, width: 250),
              ],
            ),
          ),
        ),

        /// Services title
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SkeletonBox(height: 20, width: 120),
          ),
        ),

        /// Service list skeleton
        SliverList.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const ServiceWidgetSkeleton();
          },
        ),
      ],
    );
  }
}


class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ServiceWidgetSkeleton extends StatelessWidget {
  const ServiceWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SkeletonBox(height: 18, width: 160),
              SkeletonBox(height: 28, width: 70, borderRadius: 12),
            ],
          ),

          const SizedBox(height: 12),

          /// Doctor Row
          Row(
            children: const [
              SkeletonBox(height: 36, width: 36, borderRadius: 20),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(height: 14, width: 120),
                  SizedBox(height: 6),
                  SkeletonBox(height: 12, width: 90),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Description lines
          const SkeletonBox(height: 14, width: double.infinity),
          const SizedBox(height: 6),
          const SkeletonBox(height: 14, width: 220),

          const SizedBox(height: 14),

          /// Waiting badge
          const SkeletonBox(height: 30, width: 150, borderRadius: 12),
        ],
      ),
    );
  }
}



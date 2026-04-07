import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoreMainSkeleton extends StatelessWidget {
  const StoreMainSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [
          /// 🔹 Image Skeleton
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),

          /// 🔹 Description Skeleton
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Container(height: 20, width: 180, color: Colors.grey.shade200),
                  const SizedBox(height: 12),

                  /// Type badge
                  Container(
                    height: 28,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Description lines
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 200, color: Colors.grey),

                  const SizedBox(height: 20),

                  /// Status Row
                  Container(height: 30, width: 140, color: Colors.grey),
                ],
              ),
            ),
          ),

          /// 🔹 Tabs Section
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: Column(
          //       children: [
          //         /// Tab Bar Placeholder
          //         Container(
          //           height: 45,
          //           decoration: BoxDecoration(
          //             color: Colors.grey,
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //
          //         const SizedBox(height: 16),
          //
          //         /// Tab Content Placeholder
          //         Container(
          //           height: 300,
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: Colors.grey,
          //             borderRadius: BorderRadius.circular(16),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          SliverToBoxAdapter(
            child: ProductsCategoriesSkeleton(),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, __) => const ProductItemSkeleton(),
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}

/// product widget:

class ProductItemSkeleton extends StatelessWidget {
  const ProductItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Image
          Container(
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          const SizedBox(width: 16),

          /// 🔹 Right Side
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Product Name
                  Container(height: 18, width: 150, color: Colors.grey.shade200),

                  /// Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(height: 6),
                      Container(height: 12, width: 120, color: Colors.grey.shade200),
                    ],
                  ),

                  /// Chips Row
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 24,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ],
                  ),

                  /// Bottom Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// categories skeletonizer

class ProductsCategoriesSkeleton extends StatelessWidget {
  const ProductsCategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 60,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 6, // fake number of chips
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}

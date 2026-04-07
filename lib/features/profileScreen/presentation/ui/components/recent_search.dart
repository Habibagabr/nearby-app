import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/recent_search_item.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../shared/components/header_text_style.dart';

class RecentlySearch extends StatelessWidget {
  final List<String> recentSearch;

  const RecentlySearch({
    super.key,
    required this.recentSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {

          /// 🔹 Header
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 14),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    "Recent Search",
                    textColor: AppColors.darkGray,
                  ),
                  Text(
                    "Clear",
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          /// 🔹 Real Items
          final item = recentSearch[index - 1];

          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 6, horizontal: 12),
            child: RecentSearchItem(
              recentSearch: item,
            ),
          );
        },

        /// 1 header + dynamic list length
        childCount: recentSearch.length + 1,
      ),
    );
  }
}
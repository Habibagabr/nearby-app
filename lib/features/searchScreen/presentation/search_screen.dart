import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filters_section.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/seach_bar_header.dart';

final List<String> popularSearches = [
  "Nearby coffee shops",
  "Pharmacy open now",
  "Men clothing store",
  "Best burger restaurants",
  "Supermarket delivery",
  "Kids clothing sale",
  "Gym with monthly plans",
  "Electronics store near me",
  "Hair salon for women",
  "Breakfast places nearby",
  "Pizza and pasta restaurants",
  "Flower shop delivery",
  "Pet shop supplies",
  "Bookstore offers",
  "Bakery fresh bread",
];
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SearchBarHeader()),
          const SliverToBoxAdapter(child: FilterSection()),

          SliverList.builder(
            itemCount: popularSearches.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child: Text(
                  "Popular Search",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
                  : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB), // light background
                  borderRadius: BorderRadius.circular(40), // pill shape
                  border: Border.all(
                    color: const Color(0xFFE5E7EB), // light grey border
                    width: 1,
                  ),
                ),
                child:  Text(
                  popularSearches[index-1],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151), // dark grey text
                  ),
                ),
              )
              );
            },
          ),
        ],
      ),
    );
  }
}

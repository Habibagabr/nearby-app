import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class SearchBarHeader extends StatelessWidget {
  const SearchBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(vertical: 62, horizontal: 12),
      color: AppColors.darkGray,
      child: Column(
        children: [
          Center(
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchBar(
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsetsGeometry.symmetric(horizontal: 12),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    AppColors.white,
                  ),
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  hintText: "Try: gym with pool near me",
                  leading: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Image.asset(
                        "assets/images/search_icon.png",
                        width: 20,
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/search_star.png",
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12,
                  children: [
                    Image.asset(
                      "assets/images/search_star.png",
                      width: 20,
                      height: 20,
                    ),
                    Text("Ask naturally - I understand what you mean", style: TextStyle(
                      color: AppColors.white
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

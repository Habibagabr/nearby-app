import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filters_types.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/switch.dart';
// import 'package:near_buy_gp/core/themes/app_colors.dart'; // Ensure this path is correct

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // 1. Filters Card
        Card(
          margin: EdgeInsetsGeometry.directional(start: 12),
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          clipBehavior: Clip.antiAlias,
          color: const Color(0XFFF3F4F6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/filters.png",
                  width: 18,
                  height: 18,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.tune, size: 18),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Filters",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0XFF364153),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 2. Separate Line
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0XFFE5E7EB), // A light grey for separation
        ),

        const SizedBox(height: 16),

        FiltersType(
          filterTitle: "Price Range",
          filterValues: [
            Text("Any", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$\$", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("\$\$\$", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        FiltersType(
          filterTitle: "Minimum Rating",
          filterValues: [
            Row(children: [Text("Any")]),
            Row(spacing: 6, children: [Icon(Icons.star, size: 16), Text("3")]),

            Row(spacing: 6, children: [Icon(Icons.star, size: 16), Text("4+")]),
            Row(
              spacing: 6,
              children: [Icon(Icons.star, size: 16), Text("4.5+")],
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Open Now",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              CustomSwitch()
            ],
          ),
        ),
      ],
    );
  }
}

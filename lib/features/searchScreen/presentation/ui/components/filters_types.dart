import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filter_item.dart';

class FiltersType extends StatefulWidget {
  final String filterTitle;
  final List<Widget> filterValues;

  const FiltersType({super.key, required this.filterTitle, required this.filterValues});

  @override
  FiltersTypeState createState() => FiltersTypeState();
}

class FiltersTypeState extends State<FiltersType> {
  // Track the currently selected index (-1 means none selected)
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.filterTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 24),
          // FIX: Wrap the ListView in a SizedBox with a fixed height
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.filterValues.length,
              // Remove NeverScrollableScrollPhysics to allow horizontal scrolling
              itemBuilder: (context, index) {
                return FilterItem(
                  filterValue: widget.filterValues[index],
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      print("Tapped index: $index");
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

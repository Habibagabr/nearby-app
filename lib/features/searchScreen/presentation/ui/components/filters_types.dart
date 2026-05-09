import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filter_item.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_value_type.dart';

import '../../utils/filter_item_entity.dart';

class FiltersType extends StatefulWidget {
  final String filterTitle;
  final List<FilterItemEntity> filterValues;

  const FiltersType({
    super.key,
    required this.filterTitle,
    required this.filterValues,
  });

  @override
  FiltersTypeState createState() => FiltersTypeState();
}

class FiltersTypeState extends State<FiltersType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 1. Get the current location and search state once
    final locationState = context.watch<LocationBloc>().state;
    final searchState = context.watch<SearchBloc>().state;

    final double lat = locationState.location?.latitude ?? 0.0;
    final double lng = locationState.location?.longitude ?? 0.0;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.filterTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.filterValues.length,
              itemBuilder: (context, index) {
                final item = widget.filterValues[index];
                return FilterItem(
                  filterValue: item.filterItem,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() => selectedIndex = index);

                    // 2. Prepare the event parameters
                    int? rate = searchState.miniRate;
                    bool? opened = searchState.isOpenNow;

                    if (item.filterValueType == FilterValueType.miniRate) {
                      rate = item.filterValue;
                    }

                    if (selectedIndex != 0) {
                      // 3. Send the event with ALL required context
                      context.read<SearchBloc>().add(
                        FilterValuePressed(
                          minimumRate: rate,
                          isOpenedNow: opened,
                          query: searchState.query,
                          // Keep current query
                          userLat: lat,
                          // Pass the lat
                          userLng: lng, // Pass the lng
                        ),
                      );
                    } else {
                      context.read<SearchBloc>().add(
                        FilterValuePressed(
                          minimumRate: null,
                          isOpenedNow: opened,
                          query: searchState.query,
                          // Keep current query
                          userLat: lat,
                          // Pass the lat
                          userLng: lng, // Pass the lng
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
    );
  }
}

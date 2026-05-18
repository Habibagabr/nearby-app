import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
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

int getSelectedIndex(int? rate) {
  return switch (rate) {
    null => 0,
    2 => 1,
    3 => 2,
    4 => 3,
    _ => 0,
  };
}

class FiltersTypeState extends State<FiltersType> {
  late int selectedIndex;

  @override
  Widget build(BuildContext context) {
    // 1. Get the current location and search state once
    final locationState = context.watch<LocationBloc>().state;
    final searchState = context.watch<SearchBloc>().state;
    selectedIndex = getSelectedIndex(searchState.miniRate) ;

    final double lat = locationState.location?.latitude ?? 0.0;
    final double lng = locationState.location?.longitude ?? 0.0;

    return Column(
      spacing: AppDimens.spacingM,
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

                  //  Prepare the event parameters
                  int? rate = searchState.miniRate;

                  if (item.filterValueType == FilterValueType.miniRate) {
                    rate = item.filterValue;
                  }

                  // ============================ RATE UI ============================

                  context.read<SearchBloc>().add(
                    FilterValuePressed(
                      minimumRate: selectedIndex != 0 ? rate : null,

                      userLat: lat,
                      userLng: lng,

                      isOpenedNow: searchState.isOpenNow,
                      query: searchState.query,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

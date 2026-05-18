import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filters_types.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_item_entity.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_value_type.dart';

import '../../../../../core/common_widgets/switch.dart';
import '../../../../../core/themes/app_dimen.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../bloc/search_bloc.dart';
import '../components/price_range_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/ui/components/filters_types.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_item_entity.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_value_type.dart';

import '../../../../../core/common_widgets/switch.dart';
import '../../../../../core/themes/app_dimen.dart';
import '../../../../../core/themes/app_text_style.dart';
import '../../bloc/search_bloc.dart';
import '../components/price_range_slider.dart';

final List<FilterItemEntity> rateRange = [
  FilterItemEntity(
    filterItem: Row(children: [const Text("Any")]),
    filterValue: 0,
    filterValueType: FilterValueType.miniRate,
    filterValueIndex: 0,
  ),
  FilterItemEntity(
    filterItem: Row(
      spacing: AppDimens.radiusS,
      children: [const Icon(Icons.star, size: 16), const Text("2")],
    ),
    filterValue: 2,
    filterValueType: FilterValueType.miniRate,
    filterValueIndex: 1,
  ),
  FilterItemEntity(
    filterItem: Row(
      spacing: 6,
      children: [const Icon(Icons.star, size: 16), const Text("3")],
    ),
    filterValue: 3,
    filterValueType: FilterValueType.miniRate,
    filterValueIndex: 2,
  ),
  FilterItemEntity(
    filterItem: Row(
      spacing: 6,
      children: [const Icon(Icons.star, size: 16), const Text("4+")],
    ),
    filterValue: 4,
    filterValueType: FilterValueType.miniRate,
    filterValueIndex: 2,
  ),
];

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  FilterSectionState createState() => FilterSectionState();
}

class FilterSectionState extends State<FilterSection> {
  bool isFiltersShown = false;

  void onFilterPressed() {
    setState(() {
      isFiltersShown = !isFiltersShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Read state natively within build method to catch updates safely
    final searchState = context.watch<SearchBloc>().state;

    return Column(
      spacing: AppDimens.spacingM,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 1. Filters Card
        GestureDetector(
          onTap: onFilterPressed,
          child: Card(
            margin: EdgeInsetsGeometry.directional(
              start: AppDimens.spacingM,
              top: AppDimens.spacingM,
            ),
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            clipBehavior: Clip.antiAlias,
            color: isFiltersShown ? AppColors.darkGray : AppColors.mediumGray,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              width: 120,
              child: Row(
                spacing: AppDimens.spacingS,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_list_sharp,
                    size: AppDimens.iconExtraSmall,
                    color: isFiltersShown ? AppColors.white : AppColors.darkGray,
                  ),
                  Text(
                    "Filters",
                    style: AppTextStyles.labelMedium.copyWith(
                      fontSize: 18,
                      color: isFiltersShown ? AppColors.white : AppColors.darkGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 0.5, color: AppColors.lightGray),

        if (isFiltersShown)
          Column(
            children: [
              // Price Range Slider Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Price Range",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: AppDimens.spacingXL),
                    const PriceRangeSlider(),
                    FiltersType(
                      filterTitle: "Minimum Rating",
                      filterValues: rateRange,
                    ),
                  ],
                ),
              ),
              // Open Now Filter Switch Section
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Open Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    CustomSwitch(
                      switchBallSize: 27,
                      switchTrackingHeight: 35,
                      switchTrackingWidth: 60,
                      // Logic: The switch displays active ONLY if state is strictly true.
                      // If state is false or null, the switch displays off.
                      isSwitchOn: searchState.isOpenNow == true,
                      onChange: () {
                        // Logic: If it is currently active (true), click resets it to null.
                        // If it is inactive (false or null), click activates it (true).
                        final bool? afterPressing = (searchState.isOpenNow == true) ? null : true;

                        final locationState = context.read<LocationBloc>().state;

                        context.read<SearchBloc>().add(
                          FilterValuePressed(
                            isOpenedNow: afterPressing,
                            userLng: locationState.location?.longitude,
                            userLat: locationState.location?.latitude,
                            query: searchState.query,
                            minimumRate: searchState.miniRate,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

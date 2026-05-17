import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart";

import "../../bloc/search_bloc.dart";

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State createState() => PriceRangeSliderState();
}

class PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      context.read<SearchBloc>().state.miniPrice ,
      context.read<SearchBloc>().state.maxPrice
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = context.read<LocationBloc>().state.location;
    final searchState = context.read<SearchBloc>().state;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.alwaysVisible,
        rangeValueIndicatorShape:
            const RectangularRangeSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.black,
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),

        // Adjusting track and thumb appearance
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.grey[300],
        thumbColor: Colors.black,
      ),
      child: RangeSlider(
        values: _currentRangeValues,
        min: 0,
        max: 1000,
        divisions: 100,
        labels: RangeLabels(
          '${_currentRangeValues.start.round()} EGP',
          '${_currentRangeValues.end.round()} EGP',
        ),

        onChanged: (RangeValues range) {
          setState(() {
            _currentRangeValues = range;
          });
          // ============================ PRICE SLIDER UI ============================

          context.read<SearchBloc>().add(
            PriceRangeChanged(
              minPrice: _currentRangeValues.start.toDouble(),
              maxPrice: _currentRangeValues.end.toDouble(),

              userLat: userLocation?.latitude,
              userLng: userLocation?.longitude,
            ),
          );
        },
      ),
    );
  }
}

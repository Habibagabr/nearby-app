import "package:flutter/material.dart";

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State createState() => PriceRangeSliderState();
}

class PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(100, 900);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
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
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MINI',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'MAX',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

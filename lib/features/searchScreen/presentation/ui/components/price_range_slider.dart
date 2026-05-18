import "dart:math" as math;

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart";

import "../../bloc/search_bloc.dart";

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => PriceRangeSliderState();
}

class PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();

    _currentRangeValues = RangeValues(
      context.read<SearchBloc>().state.miniPrice,
      context.read<SearchBloc>().state.maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = context.read<LocationBloc>().state.location;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.alwaysVisible,

        // CUSTOM SHAPE
        rangeValueIndicatorShape:
        const FixedRectangularRangeSliderValueIndicatorShape(),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        valueIndicatorColor: Colors.black,
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.grey,

        thumbColor: Colors.black,
      ),

      child: RangeSlider(
        values: _currentRangeValues,

        min: 0,
        max: 1000,

        labels: RangeLabels(
          "${_currentRangeValues.start.round()} EGP",
          "${_currentRangeValues.end.round()} EGP",
        ),

        onChanged: (RangeValues range) {
          setState(() {
            _currentRangeValues = range;
          });

          context.read<SearchBloc>().add(
            PriceRangeChanged(
              minPrice: range.start,
              maxPrice: range.end,
              userLat: userLocation?.latitude,
              userLng: userLocation?.longitude,
            ),
          );
        },
      ),
    );
  }
}

class FixedRectangularRangeSliderValueIndicatorShape
    extends RangeSliderValueIndicatorShape {
  const FixedRectangularRangeSliderValueIndicatorShape();

  static const double _labelPadding = 10;
  static const double _triangleHeight = 8;
  static const double _radius = 8;
  static const double _distanceFromThumb = 14;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool isDiscrete = false,
        bool isOnTop = false,
        required TextPainter labelPainter,
        double textScaleFactor = 1.0,
        Size sizeWithOverflow = Size.zero,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        TextDirection textDirection = TextDirection.ltr,
        double value = 0.0,
        Thumb thumb = Thumb.start,
      }) {
    final Canvas canvas = context.canvas;

    final double scale =
        activationAnimation.value * enableAnimation.value;

    if (scale == 0) return;

    final double labelWidth =
        labelPainter.width + (_labelPadding * 3);

    final double labelHeight =
        labelPainter.height + (_labelPadding * 2);

    // ================= FIXED POSITIONING =================

    double dx = center.dx - (labelWidth / 2);

    // Clamp INSIDE parent safely
    dx = math.max(0, dx);

    dx = math.min(
      dx,
      parentBox.size.width - labelWidth,
    );

    final double dy =
        center.dy - labelHeight - _triangleHeight - _distanceFromThumb;

    final Rect rect = Rect.fromLTWH(
      dx,
      dy,
      labelWidth,
      labelHeight,
    );

    final RRect rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(_radius),
    );

    final Paint paint = Paint()
      ..color = sliderTheme.valueIndicatorColor ?? Colors.black;

    // Bubble
    canvas.drawRRect(rRect, paint);

    // Triangle
    final Path triangle = Path()
      ..moveTo(center.dx - 8, rect.bottom)
      ..lineTo(center.dx + 8, rect.bottom)
      ..lineTo(center.dx, rect.bottom + _triangleHeight)
      ..close();

    canvas.drawPath(triangle, paint);

    // Text
    final double textX =
        rect.left + ((rect.width - labelPainter.width) / 2);

    final double textY =
        rect.top + ((rect.height - labelPainter.height) / 2);

    labelPainter.paint(
      canvas,
      Offset(textX, textY),
    );
  }
  @override
  Size getPreferredSize(
      bool isEnabled,
      bool isDiscrete, {
        required TextPainter labelPainter,
        required double textScaleFactor,
      }) {
    final double width = labelPainter.width + 20;
    final double height = labelPainter.height + 20;

    return Size(width, height);
  }
}

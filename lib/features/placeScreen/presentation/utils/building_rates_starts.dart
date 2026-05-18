import 'package:flutter/material.dart';



/// Builds rating stars based on the rate
Widget buildRatingStars(double rate, {double iconSize = 20}) {
  List<Widget> stars = [];

  for (int i = 1; i <= 5; i++) {
    if (rate >= i) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: iconSize));
    } else if (rate >= i - 0.5) {
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: iconSize));
    } else {
      stars.add(Icon(Icons.star_border, color: Colors.amber, size: iconSize));
    }
  }

  return Row(mainAxisSize: MainAxisSize.min, children: stars);
}

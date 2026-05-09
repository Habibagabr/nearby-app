import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rate;
  final int maxStars;

  const RatingStars({
    super.key,
    required this.rate,
    this.maxStars = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        if (index < rate.floor()) {
          // Full star
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index < rate && rate % 1 != 0) {
          // Half star (if index matches the decimal part)
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          // Empty star
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }
}

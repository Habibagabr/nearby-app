import 'package:flutter/material.dart';

import 'category_icon_resolver.dart';
import 'nearby_pin_entity.dart';

class PlaceMarkerWidget extends StatelessWidget {
  final NearbyPinEntity place;

  const PlaceMarkerWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final iconPath = CategoryIconResolver.resolve(place.placeCategory);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(iconPath, width: 22, height: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.placeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 22, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        place.placeRate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      if (place.placeState)
                        const Text(
                          'Open',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        const Text(
                          'Closed',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

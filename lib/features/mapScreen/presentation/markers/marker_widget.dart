import 'package:flutter/material.dart';
import 'category_icon_resolver.dart';
import '../../domain/entity/nearby_pin_entity.dart';

class PlaceMarkerWidget extends StatelessWidget {
  final NearbyPinEntity place;
  // 1. Define the callback function
  final VoidCallback onTap;

  const PlaceMarkerWidget({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCluster = place.count > 1;

    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: isCluster ? _buildClusterUI() : _buildBusinessUI(),
      ),
    );
  }

  Widget _buildClusterUI() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blueAccent, width: 6),
        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10)],
      ),
      child: Center(
        child: Text(
          '${place.count}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessUI() {
    final iconPath = CategoryIconResolver.resolve(place.placeType);
    return Container(
      width: 300,
      height: 110,
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
            child: Icon(iconPath, size: 22),
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
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 22, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(place.placeRate.toString(), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    Text(
                      place.placeState == "open" ? 'Open' : 'Closed',
                      style: TextStyle(color: place.placeState == "open" ? Colors.green : Colors.red, fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

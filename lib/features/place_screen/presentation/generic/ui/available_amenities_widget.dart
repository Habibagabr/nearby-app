import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/genericEntities/amenities_enum.dart';
class AvailableAmenitiesWidget extends StatelessWidget {
  final List<Amenity> amenitiesList;

  const AvailableAmenitiesWidget({
    super.key,
    required this.amenitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: amenitiesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 12,
          childAspectRatio: 3.5,
        ),
        itemBuilder: (context, index) {
          return _AmenityItem(
            amenity: amenitiesList[index],
          );
        },
      ),
    );
  }
}


class _AmenityItem extends StatelessWidget {
  final Amenity amenity;

  const _AmenityItem({
    required this.amenity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Circle
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F9EE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              amenity.icon,
              color: const Color(0xFF16A34A),
              size: 20,
            ),
          ),

          const SizedBox(width: 8),

          // Label
          Text(
            amenity.label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

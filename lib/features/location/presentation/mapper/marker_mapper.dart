import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';

import '../resources/assests_cach.dart';

class MarkerMapper {
  static Marker toMarker(NearbyPlaceEntity  place, VoidCallback onTap) {
    return Marker(
      markerId: MarkerId(place.id),
      position: LatLng(place.lat, place.lng),
      icon: MarkerIconsCache.instance.getIcon(place.category),
      onTap: onTap,
      infoWindow: InfoWindow(title: place.name),
    );
  }
}

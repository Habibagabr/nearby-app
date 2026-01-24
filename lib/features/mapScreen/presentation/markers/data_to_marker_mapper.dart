import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'marker_cache.dart';
import 'nearby_pin_entity.dart';

class MarkerMapper {
  static Future<Marker> toMarker(NearbyPinEntity place) async {
    final icon = await MarkerCache.get(place);

    return Marker(
      markerId: MarkerId(place.placeId),
      position: LatLng(place.placeLat, place.placeLng),
      icon: icon,
    );
  }
}

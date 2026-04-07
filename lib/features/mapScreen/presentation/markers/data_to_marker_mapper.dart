import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import '../../domain/entity/nearby_pin_entity.dart';
import 'marker_widget.dart';

class MarkerMapper {
  // Static cache to prevent repeated widget-to-bitmap conversions
  static final Map<String, BitmapDescriptor> _iconCache = {};

  static Future<Marker> toMarker(NearbyPinEntity place , VoidCallback onTap) async {
    try {
      final bool isCluster = place.count > 1;
      // Key by count for clusters, by ID for unique businesses
      final String cacheKey = isCluster ? "cluster_${place.count}" : "place_${place.placeId}";

      if (!_iconCache.containsKey(cacheKey)) {
        final widget = PlaceMarkerWidget(place: place , onTap: onTap);
        _iconCache[cacheKey] = await widget.toBitmapDescriptor(
          logicalSize: const Size(300, 300),
          imageSize: const Size(300, 300),
        );
      }

      return Marker(
        markerId: MarkerId(place.placeId),
        position: LatLng(place.placeLat, place.placeLng),
        icon: _iconCache[cacheKey]!,
        anchor: const Offset(0.5, 0.5),
        onTap:onTap,
      );
    } catch (e) {
      debugPrint("Marker Error: $e");
      return Marker(markerId: MarkerId(place.placeId), position: LatLng(place.placeLat, place.placeLng) , onTap:  onTap);
    }
  }
}

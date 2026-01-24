import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import 'marker_widget.dart';
import 'nearby_pin_entity.dart';


class MarkerCache {
  static final Map<String, BitmapDescriptor> _cache = {};

  static Future<BitmapDescriptor> get(NearbyPinEntity place) async {
    if (_cache.containsKey(place.placeId)) {
      return _cache[place.placeId]!;
    }

    final widget = PlaceMarkerWidget(place: place);

    final icon = await widget.toBitmapDescriptor(
      logicalSize: const Size(200, 200),
      imageSize: const Size(200, 200),
    );

    _cache[place.placeId] = icon;
    return icon;
  }
}

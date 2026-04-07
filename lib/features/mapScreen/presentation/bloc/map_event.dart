import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class FetchMapData extends MapEvent {
  final LatLngBounds bounds;
  final double zoom;
  final LatLng center;

  FetchMapData({
    required this.bounds,
    required this.zoom,
    required this.center,
  });
}

class MarkerSelected extends MapEvent{
  final String placeId;
  final String businessCategory;

  MarkerSelected({
    required this.placeId,
    required this.businessCategory
});

}

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../homeScreen/domain/entities/nearby_places_entity.dart';

enum MapStatus { initial, loading, loaded , error}

class MapState {
  final MapStatus status;
  final Set<Marker> currentMarkers;

  const MapState({
    required this.status,
    required this.currentMarkers
  });

  factory MapState.initial() {
    return const MapState(status: MapStatus.initial, currentMarkers: {});
  }

  MapState copyWith({
    MapStatus? status,
    Set<Marker>? currentMarkers,
  }) {
    return MapState(
      status: status ?? this.status,
        currentMarkers: currentMarkers ?? this.currentMarkers

    );
  }
}

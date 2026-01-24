import '../../../homeScreen/domain/entities/nearby_places_entity.dart';

enum MapStatus { initial, loading, loaded , error}

class MapState {
  final MapStatus status;
  final List<NearbyPlaceEntity> places;

  const MapState({
    required this.status,
    required this.places,
  });

  factory MapState.initial() {
    return const MapState(status: MapStatus.initial, places: []);
  }

  MapState copyWith({
    MapStatus? status,
    List<NearbyPlaceEntity>? places,
  }) {
    return MapState(
      status: status ?? this.status,
      places: places ?? this.places,
    );
  }
}

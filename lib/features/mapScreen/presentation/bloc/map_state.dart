import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/util/screens_enum.dart';

sealed class MapNavAction {
  final ScreensType screenType;
  final String placeId;

  MapNavAction({required this.placeId, required this.screenType});
}

class NavigateToDetailsScreen extends MapNavAction {
  NavigateToDetailsScreen({required ScreensType screenType, required String placeId}) : super(placeId: placeId, screenType: screenType);
}

//////////////////////////////////////////////////////////////////////////////////////////

sealed class MapViewState {}

enum MapStatus { initial, loading, loaded, error }

class MapState {
  final MapStatus status;
  final Set<Marker> currentMarkers;
  final MapNavAction? navAction;

  const MapState({
    required this.status,
    required this.currentMarkers,
    this.navAction,
  });

  factory MapState.initial() {
    return const MapState(
      status: MapStatus.initial,
      currentMarkers: {},
      navAction: null,
    );
  }

  MapState copyWith({
    MapStatus? status,
    Set<Marker>? currentMarkers,
    MapNavAction? navAction,
  }) {
    return MapState(
      status: status ?? this.status,
      currentMarkers: currentMarkers ?? this.currentMarkers,
      navAction: navAction,
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/util/screens_enum.dart';
import '../../../homeScreen/domain/entities/nearby_places_entity.dart';

sealed class MapNavigationAction{}
class NavigateToStoreDetails extends MapNavigationAction {
  final ScreensType screensType;
  final String placeId;
  NavigateToStoreDetails({required this.placeId, required this.screensType});
}

class NavigateToServiceDetails extends MapNavigationAction {
  final ScreensType screensType;
  final String placeId;
  NavigateToServiceDetails({required this.placeId, required this.screensType});
}

class NavigateToGeneralDetails extends MapNavigationAction {
  final ScreensType screensType;
  final String placeId;
  NavigateToGeneralDetails({required this.placeId, required this.screensType});
}

enum MapStatus { initial, loading, loaded , error}

class MapState {
  final MapStatus status;
  final Set<Marker> currentMarkers;
  final MapNavigationAction? navAction;

  const MapState({
    required this.status,
    required this.currentMarkers,
    this.navAction,
  });

  factory MapState.initial() {
    return const MapState(status: MapStatus.initial, currentMarkers: {}  , navAction: null);
  }

  MapState copyWith({
    MapStatus? status,
    Set<Marker>? currentMarkers,
    MapNavigationAction? navAction,
  }) {
    return MapState(
      status: status ?? this.status,
        currentMarkers: currentMarkers ?? this.currentMarkers,
      navAction: navAction,
    );
  }

}

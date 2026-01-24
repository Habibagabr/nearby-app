import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../homeScreen/domain/usecases/get_places_in_bound.dart';
import 'map_event.dart';
import 'map_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


@Injectable()
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetPlacesInBoundsUseCase getPlaces;
  LatLngBounds? _lastFetchedBounds;

  MapBloc(this.getPlaces) : super(MapState.initial()) {
    on<ViewportChanged>(_onViewportChanged);
  }

  Future<void> _onViewportChanged(
    ViewportChanged event,
    Emitter<MapState> emit,
  ) async {
    final newBounds = LatLngBounds(
      northeast: LatLng(event.north, event.east),
      southwest: LatLng(event.south, event.west),
    );

    //check for : if the user not changing its boundaries
    if (_lastFetchedBounds != null &&
        _isInside(newBounds, _lastFetchedBounds!)) {
      return;
    }

    _lastFetchedBounds = newBounds;

    emit(state.copyWith(status: MapStatus.loading));

    final places = await getPlaces(
      north: event.north,
      south: event.south,
      east: event.east,
      west: event.west,
    );
    places.fold(
          (error) {
        // Print the error details
        debugPrint(' MapBloc Error: ${error.toString()}');

        emit(state.copyWith(status: MapStatus.error, places: []));
      },
          (data) {
        // 2. Print how many places were found
        debugPrint(' MapBloc Success: ${data.length} places found');

        // 3. Optional: Print the names of the places to check data quality
        for (var place in data) {
          debugPrint(
              ' Place: ${place.name} | Lat: ${place.lat}, Lng: ${place.lng}');
        }

        emit(state.copyWith(status: MapStatus.loaded, places: data));
      },
    );
  }

  bool _isInside(LatLngBounds inner, LatLngBounds outer) {
    return inner.northeast.latitude <= outer.northeast.latitude &&
        inner.southwest.latitude >= outer.southwest.latitude &&
        inner.northeast.longitude <= outer.northeast.longitude &&
        inner.southwest.longitude >= outer.southwest.longitude;
  }
}

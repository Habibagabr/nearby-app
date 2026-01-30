import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:injectable/injectable.dart';
import 'map_event.dart';
import 'map_state.dart';
import 'package:near_buy_gp/features/mapScreen/domain/usecases/get_nearby_pins.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/markers/data_to_marker_mapper.dart';

import 'package:stream_transform/stream_transform.dart'; // Required for debouncing


// 1. Define a debounce transformer to limit how often events are processed
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

@LazySingleton()
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetNearbyPinsUseCase _useCase;
  final GeoHasher _geoHasher = GeoHasher();

  final Map<int, Map<String, Map<String, Marker>>> _markersCache = {};
  final Set<String> _visitedCells = {};
  bool _isFetching = false;

  MapBloc({required GetNearbyPinsUseCase useCase})
      : _useCase = useCase,
        super(MapState.initial()) {
    // FIX 1: Apply debounce (300ms) and restartable() to cancel old requests
    on<FetchMapData>(
      _onFetchMapData,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onFetchMapData(
      FetchMapData event,
      Emitter<MapState> emit,
      ) async {
    final int precision = _getPrecision(event.zoom);
    _markersCache.putIfAbsent(precision, () => {});

    // 2. Identify specifically which hashes in the viewport are missing
    final Set<String> visibleHashes = _generateHashesForViewport(event.center, precision);
    final List<String> missingHashes = visibleHashes
        .where((h) => !_visitedCells.contains('$precision:$h'))
        .toList();

    // Immediate Cache UI Update (Zero Latency)
    // Show what we already have before even checking the network
    final cachedMarkers = _filterMarkers(event.bounds, precision);
    if (cachedMarkers.isNotEmpty) {
      emit(state.copyWith(
        status: MapStatus.loaded,
        currentMarkers: cachedMarkers,
      ));
    }

    //  Stop request if everything visible is already cached
    if (missingHashes.isEmpty) {
      print("DEBUG: All visible cells cached. Skipping request.");
      return;
    }

    if (_isFetching) return;
    _isFetching = true;

    // Optional: Only show loading if we have NO markers yet
    if (state.currentMarkers.isEmpty) {
      emit(state.copyWith(status: MapStatus.loading));
    }

    final result = await _useCase.getNearbyPinsUseCase(
      event.bounds.southwest.longitude,
      event.bounds.southwest.latitude,
      event.bounds.northeast.longitude,
      event.bounds.northeast.latitude,
      event.zoom,
    );

    await result.fold(
          (error) async {
        _isFetching = false;
        emit(state.copyWith(status: MapStatus.error));
      },
          (entities) async {
        final markers = await Future.wait(entities.map(MarkerMapper.toMarker));

        for (final marker in markers) {
          final geohash = _geoHasher.encode(
            marker.position.longitude,
            marker.position.latitude,
            precision: precision,
          );

          _markersCache[precision]!.putIfAbsent(geohash, () => <String, Marker>{});
          _markersCache[precision]![geohash]![marker.markerId.value] = marker;
        }

        // Mark all hashes in the current view as "visited"
        for (final h in visibleHashes) {
          _visitedCells.add('$precision:$h');
        }

        _isFetching = false;

        emit(state.copyWith(
          status: MapStatus.loaded,
          currentMarkers: _filterMarkers(event.bounds, precision),
        ));
      },
    );
  }

  // Updated filter to correctly return all cached markers for current precision
  Set<Marker> _filterMarkers(LatLngBounds bounds, int precision) {
    if (!_markersCache.containsKey(precision)) return {};

    return _markersCache[precision]!
        .values
        .expand((m) => m.values)
        .toSet();
  }

  ///  Center + 8 neighbors
  Set<String> _generateHashesForViewport(LatLng center, int precision) {
    final String centerHash = _geoHasher.encode(
      center.longitude,
      center.latitude,
      precision: precision,
    );

    final neighbors = _geoHasher.neighbors(centerHash);
    return {centerHash, ...neighbors.values};
  }

  ///  Matches backend geographic levels
  int _getPrecision(double zoom) {
    if (zoom <= 4) return 2; // Country
    if (zoom <= 7) return 3; // Region
    if (zoom <= 10) return 4; // City
    if (zoom <= 12) return 5; // District
    if (zoom <= 14) return 6; // Neighborhood
    if (zoom <= 16) return 7; // Street
    return 8; // Building
  }
}

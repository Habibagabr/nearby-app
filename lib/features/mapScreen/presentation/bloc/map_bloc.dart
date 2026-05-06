import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/mapScreen/domain/usecases/get_nearby_pins.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/markers/data_to_marker_mapper.dart';
import '../../data/map_worker/process_geohashes_in_background.dart';
import '../../data/models/map_worker_input.dart';
import '../../domain/usecases/get_place_screen_category.dart';
import '../../utils/transformer.dart';
import 'map_event.dart';
import 'map_state.dart';

@LazySingleton()
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetNearbyPinsUseCase getNearbyPinsUseCase;

  // cache for the pre-fetched tiles before :
  // key : " precision + geohash "
  // value : set " list " of markers followed this part
  /// why linked ?????
  final LinkedHashMap<String, Set<Marker>> _tileCache = LinkedHashMap();
  static const int _maxTiles = 200;

  MapBloc({required this.getNearbyPinsUseCase}) : super(MapState.initial()) {
    on<FetchMapData>(
      _onFetchMapData,
      transformer: debounce(const Duration(milliseconds: 300)),
    );

    on<MarkerSelected>((event, emit) {
      if (kDebugMode) {
        print(
          "DEBUG: Marker Tapped! ID: ${event.placeId}, Category: ${event.businessCategory}",
        );
      }
      _onMarkerSelected(
        placeId: event.placeId,
        businessCategory: event.businessCategory,
        emit: emit,
      );
    });
  }

  Future<void> _onFetchMapData(
    FetchMapData event,
    Emitter<MapState> emit,
  ) async {
    if (kDebugMode) {
      print("PRINT: THE SELECTED CATEGORY IS : ${event.businessType}");
    }
    if (event.businessType != null) {
      clearMapCache();
      emit(state.copyWith(currentMarkers: {}));
    }
    final precision = _getPrecision(event.zoom);

    // 1. Instant Cache Display
    // get the instant already found markers based on the boundaries of the map and the precision
    final cachedMarkers = _filterFromCache(event.bounds, precision);
    if (cachedMarkers.isNotEmpty) {
      emit(
        state.copyWith(status: MapStatus.loaded, currentMarkers: cachedMarkers),
      );
    }
    // 2. Skip network if area is already fully cached
    // after getting the instant cached markers we should complete bec :
    // what if we are in partial place ( half of it cashed and the other the first time we see it )
    // this line check if the whole area is cached or not , if yes we already give all the cached marker for it if not we will complete to get them
    if (_isAreaCached(event.center, precision)) return;

    final result = await getNearbyPinsUseCase.getNearbyPinsUseCase(
      swLng: event.bounds.southwest.longitude,
      swLat: event.bounds.southwest.latitude,
      neLng: event.bounds.northeast.longitude,
      neLat: event.bounds.northeast.latitude,
      zoom: event.zoom,
      businessType: event.businessType?.toLowerCase(),
    );
    await result.fold(
      (failure) async => emit(state.copyWith(status: MapStatus.error)),
      (data) async {
        // 3. BACKGROUND: Heavy Geohash Calculation
        final workerResult = await compute(
          processGeohashesInBackground,
          MapWorkerInput(data, precision),
        );

        // 4. MAIN THREAD BATCHING: Convert Widgets to Markers in chunks
        for (var entry in workerResult.groupedEntities.entries) {
          final Set<Marker> markersInTile = {};

          for (var entity in entry.value) {
            final marker = await MarkerMapper.toMarker(
              place: entity,
              onTap: () => add(
                MarkerSelected(
                  placeId: entity.placeId,
                  businessCategory: "store",/// FIX EL HABL DAAAAAH
                ),
              ),
            );
            markersInTile.add(marker);
          }

          // Update LRU Cache
          _tileCache.remove(entry.key); // Refresh position
          _tileCache[entry.key] = markersInTile;

          // Yield to let UI render (Prevent freezing)
          await Future.delayed(Duration.zero);
        }

        // 5. Cleanup Cache (Evict oldest tiles)
        while (_tileCache.length > _maxTiles) {
          _tileCache.remove(_tileCache.keys.first);
        }

        emit(
          state.copyWith(
            status: MapStatus.loaded,
            currentMarkers: _filterFromCache(event.bounds, precision),
          ),
        );
      },
    );
  }

  Set<Marker> _filterFromCache(LatLngBounds bounds, int precision) {
    return _tileCache.entries
        .where((e) => e.key.startsWith('$precision:'))
        .expand((e) => e.value)
        .where((m) => bounds.contains(m.position))
        .toSet();
  }

  bool _isAreaCached(LatLng center, int p) {
    final hash = GeoHasher().encode(
      center.longitude,
      center.latitude,
      precision: p,
    );
    return _tileCache.containsKey("$p:$hash");
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

  void _onMarkerSelected({
    required String businessCategory,
    required String placeId,
    required Emitter<MapState> emit,
  }) {
    final placeScreenCategory = getPlaceScreenCategoryUseCase(
      businessCategory.toLowerCase(),
    );
    emit(
      state.copyWith(
        navAction: NavigateToDetailsScreen(
          placeId: placeId,
          screenType: placeScreenCategory,
        ),
      ),
    );
  }

  void clearMapCache() {
    _tileCache.clear();
  }
}

import 'package:dart_geohash/dart_geohash.dart';

import '../../domain/entity/nearby_pin_entity.dart';
import '../models/map_worker_input.dart';
import '../models/map_worker_result.dart';

// in case we don't have this markers before we have to save each of them
// is we pre-judge that this entity not with us and take time in converting its hash ??????

MapWorkerResult processGeohashesInBackground(MapWorkerInput input) {
  final geoHasher = GeoHasher();
  final Map<String, List<NearbyPinEntity>> grouped = {};

  for (var entity in input.entities) {
    final hash = geoHasher.encode(entity.placeLng, entity.placeLat, precision: input.precision);
    final key = "${input.precision}:$hash";
    grouped.putIfAbsent(key, () => []).add(entity);
  }
  return MapWorkerResult(grouped);
}

import '../../domain/entity/nearby_pin_entity.dart';

// map of String " precision + geohash " and list of entities which will be later
// converted to markers " in the ui layer "
class MapWorkerResult {
  final Map<String, List<NearbyPinEntity>> groupedEntities;
  MapWorkerResult(this.groupedEntities);
}
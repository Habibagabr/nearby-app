import '../../domain/entity/nearby_pin_entity.dart';


// this model will be input to the worker to organized them in a map of :
// key : precision + geo hash
// value : list of markers followed this key
class MapWorkerInput {
  final List<NearbyPinEntity> entities;
  final int precision;
  MapWorkerInput(this.entities, this.precision);
}



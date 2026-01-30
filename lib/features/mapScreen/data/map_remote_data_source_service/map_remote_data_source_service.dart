import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/features/mapScreen/data/models/nearby_pin_model.dart';

abstract class MapRemoteDataSource {
  Future<Either<Exception,List<NearbyPinModel>>> getNearbyPlacesMarkers(
    double swLng,
    double swLat,
    double neLng,
    double neLat,
    double zoom,
  );
}

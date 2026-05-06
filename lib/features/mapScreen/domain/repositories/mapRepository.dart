import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/mapScreen/domain/entity/nearby_pin_entity.dart';

abstract class MapRepository {
  Future<Either<Failure, List<NearbyPinEntity>>> getNearbyPins(
    double swLng,
    double swLat,
    double neLng,
    double neLat,
    double zoom,
    String? businessType,
  );
}

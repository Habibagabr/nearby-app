import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NearbyPlaceEntity>>> getPlacesInBounds({
    required double west,
    required double north,
    required double east,
    required double south,
});

}
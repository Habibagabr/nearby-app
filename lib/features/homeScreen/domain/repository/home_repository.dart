import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NearbyPlaceEntity>>> getNearbyPlaces(
      {required double lat, required  double lng ,required int pageNum , required int limit , String ? businessCategory});


}
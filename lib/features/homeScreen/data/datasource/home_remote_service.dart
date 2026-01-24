import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/features/homeScreen/data/models/nearby_places_model.dart';

abstract class HomeRemoteService{
  Future<Either<Exception , List<NearbyPlaceModel>>> getPlacesInBounds(
      double west,
      double north,
      double east,
      double south,
      );

}
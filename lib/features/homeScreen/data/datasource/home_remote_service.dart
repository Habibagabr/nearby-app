import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/features/homeScreen/data/models/nearby_places_model.dart';

abstract class HomeRemoteService {

  Future<Either<Exception, List<NearbyPlaceModel>>> getNearbyPlaces({
    required double lat,
    required double lng,
    required int pageNum ,
    required int limit ,
    String? businessCategory,
  });
}

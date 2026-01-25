import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';


@LazySingleton()
class GetNearbyPlacesUseCase {
  final HomeRepository repository;
  GetNearbyPlacesUseCase(this.repository);

  Future<Either<String, List<NearbyPlaceEntity>>> call({
   required double lat,
    required double lng,
    required int pageNum , required int limit
  }) async {
    final result = await repository.getNearbyPlaces(
      lat: lat,
      lng: lng,
      pageNum: pageNum,
      limit: limit
    );

    // Use fold to return the final Either result
    return result.fold(
          (failure) => Left(failure.msg??""), // Convert Failure object to String message
          (entities) => Right(entities),      // Return the data
    );
  }
}

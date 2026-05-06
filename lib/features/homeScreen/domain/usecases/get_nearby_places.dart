import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';

@LazySingleton()
class GetNearbyPlacesUseCase {
  final HomeRepository repository;

  GetNearbyPlacesUseCase(this.repository);

  Future<Either<AppFailure, List<NearbyPlaceEntity>>> call({
    required double lat,
    required double lng,
    required int pageNum,
    required int limit,
    String? businessCategory,
  }) async {
    return await repository.getNearbyPlaces(
      lat: lat,
      lng: lng,
      pageNum: pageNum,
      limit: limit,
      businessCategory: businessCategory,
    );
  }
}

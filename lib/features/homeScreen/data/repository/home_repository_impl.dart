import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/core/error/exceptions_to_failure_handler.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart';

import '../datasource/home_remote_service.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteService service;

  HomeRepositoryImpl(this.service);

  @override
  Future<Either<AppFailure, List<NearbyPlaceEntity>>> getNearbyPlaces({
    required double lat,
    required double lng,
    required int pageNum,
    required int limit,
    String? businessCategory,
  }) async {
    try {
      final data = await service.getNearbyPlaces(
        lng: lng,
        lat: lat,
        pageNum: pageNum,
        limit: limit,
        businessCategory: businessCategory,
      );
      return Right(data.map((nearbyPlace) => nearbyPlace.toEntity()).toList());
    } catch (e) {
      return Left(ExceptionsToFailureHandler.handler(e));
    }
  }
}

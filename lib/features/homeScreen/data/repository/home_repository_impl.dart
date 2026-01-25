import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/errors/error_mapper.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart';

import '../datasource/home_remote_service.dart';
import '../datasource/home_remote_service_impl.dart';



@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteService service;
  HomeRepositoryImpl(this.service);
  @override
  Future<Either<Failure, List<NearbyPlaceEntity>>> getPlacesInBounds({
    required double west,
    required double north,
    required double east,
    required double south,
  }) async {
    try {
      //  Convert MODELS → ENTITIES
      final entities = nearbyPlacesMock
          .map((model) => model.toEntity())
          .toList();

      return Right(entities);
    } catch (e) {
      return Left(
        UnknownFailure(msg: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<NearbyPlaceEntity>>> getNearbyPlaces( {required double lat, required  double lng ,  required int pageNum , required int limit}) async {
    final data = await service.getNearbyPlaces(lng:lng, lat:lat ,pageNum: pageNum , limit: limit );
    return data.fold(
          (exception) => Left(mapExceptionToFailure(exception)),
          (models) => Right(models.map((model) => model.toEntity()).toList(),
      ),
    );
    }


}

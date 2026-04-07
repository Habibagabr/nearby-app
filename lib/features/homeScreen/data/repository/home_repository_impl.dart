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
  Future<Either<Failure, List<NearbyPlaceEntity>>> getNearbyPlaces( {required double lat, required  double lng ,  required int pageNum , required int limit , String? businessCategory}) async {
    final data = await service.getNearbyPlaces(lng:lng, lat:lat ,pageNum: pageNum , limit: limit , businessCategory: businessCategory );
    return data.fold(
          (exception) => Left(mapExceptionToFailure(exception)),
          (models) => Right(models.map((model) => model.toEntity()).toList(),
      ),
    );
    }


}

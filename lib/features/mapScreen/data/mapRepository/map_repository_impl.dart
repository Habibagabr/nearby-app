import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/errors/error_mapper.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/mapScreen/data/map_remote_data_source_service/map_remote_data_source_service.dart';
import 'package:near_buy_gp/features/mapScreen/domain/entity/nearby_pin_entity.dart';
import 'package:near_buy_gp/features/mapScreen/domain/repositories/mapRepository.dart';

@LazySingleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapRemoteDataSource mapRemoteDataSource;

  MapRepositoryImpl({required this.mapRemoteDataSource});

  @override
  Future<Either<Failure, List<NearbyPinEntity>>> getNearbyPins(
    double swLng,
    double swLat,
    double neLng,
    double neLat,
    double zoom,
    String? businessType,
  ) async {
    final data = await mapRemoteDataSource.getNearbyPlacesMarkers(
      swLng,
      swLat,
      neLng,
      neLat,
      zoom,
      businessType
    );
    return data.fold(
      (error) => Left(mapExceptionToFailure(error)),
      (models) => Right(models.map((model) => model.toEntity()).toList()),
    );
  }
}

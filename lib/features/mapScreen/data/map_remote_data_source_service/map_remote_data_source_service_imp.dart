import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/mapScreen/data/models/nearby_pin_model.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import 'map_remote_data_source_service.dart';

@LazySingleton(as: MapRemoteDataSource)
class MapRemoteDataSourceImpl extends MapRemoteDataSource {
  final Dio dio;
  MapRemoteDataSourceImpl({required this.dio});
  @override
  Future<Either<Exception,List<NearbyPinModel>>> getNearbyPlacesMarkers(
    double swLng,
    double swLat,
    double neLng,
    double neLat,
    double zoom,
  ) async {
    try {
      final response = await dio.get("/api/business/map-view", queryParameters: {
        "swLat": swLat,
        "swLng": swLng,
        "neLat": neLat,
        "neLng": neLng,
        "zoom": zoom
      });
      final data = response.data;
      final List<NearbyPinModel> dataList =
      (data as List)
          .map((marker) => NearbyPinModel.fromJson(marker))
          .toList();
      return Right(dataList);
    }on DioException catch (e) {
      return Left(Exception(e.message ?? "Connection Error"));
    } catch (e) {
      return Left(Exception("Unexpected Error: ${e.toString()}"));
    }
  }
}

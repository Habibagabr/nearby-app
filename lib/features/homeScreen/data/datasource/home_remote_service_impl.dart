import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/homeScreen/data/datasource/home_remote_service.dart';
import 'package:near_buy_gp/features/homeScreen/data/models/nearby_places_model.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: HomeRemoteService)
class HomeRemoteServiceImpl implements HomeRemoteService {
  final Dio dio;

  HomeRemoteServiceImpl(this.dio);

  @override
  Future<Either<Exception, List<NearbyPlaceModel>>> getNearbyPlaces({
    required double lat,
    required double lng,
    required int pageNum,
    required int limit,
    String? businessCategory,
  }) async {
    final Map<String, dynamic> query = {
      'lat': lat,
      'lng': lng,
      'page': pageNum,
      'limit': limit,
    };
    if(businessCategory!=null){
      query['category']=businessCategory;
    }
    try {
      final result = await dio.get(
        "/api/business/nearby",
        queryParameters: query,
        options: Options(extra: {'requiresToken': false}),
      );

      final Map<String, dynamic> responseBody = result.data;

      final List<dynamic> businessList = responseBody['businesses'];

      final List<NearbyPlaceModel> places = businessList
          .map(
            (json) => NearbyPlaceModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      return Right(places);
    } on DioException catch (e) {
      return Left(Exception(e.message ?? "Connection Error"));
    } catch (e) {
      return Left(Exception("Unexpected Error: ${e.toString()}"));
    }
  }
}

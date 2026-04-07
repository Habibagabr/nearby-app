import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/place_screen/data/dataSource/places_remote_data_source.dart';
import 'package:near_buy_gp/features/place_screen/data/models/category_model.dart';
import 'package:near_buy_gp/features/place_screen/data/models/place_model.dart';

@LazySingleton(as: PlacesRemoteDataSource)
class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  final Dio dio;

  PlacesRemoteDataSourceImpl(this.dio);

  @override
  Future<PlaceModel> getPlace({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  }) async {
    final Map<String, dynamic> query = {'page': page, 'limit': limit};

    if (categoryId != null) {
      query['categoryId'] = categoryId;
    }

    final response = await dio.get(
      '/api/business/$placeId',
      queryParameters: query,
    );

    if (response.statusCode == 200) {
      return PlaceModel.fromJson(response.data);
    }

    throw Exception('Failed to load place');
  }

  @override
  Future<List<CategoryModel>> getPlaceCategories(String placeId) async {
    final response = await dio.get('/api/categories/business/$placeId');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    }

    throw Exception('Failed to load categories');
  }
}

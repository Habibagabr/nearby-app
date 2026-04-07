import '../models/category_model.dart';
import '../models/place_model.dart';

abstract class PlacesRemoteDataSource {
  Future<PlaceModel> getPlace({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  });

  Future<List<CategoryModel>> getPlaceCategories(String placeId);
}

import 'package:near_buy_gp/features/place_screen/data/models/category_model.dart';
import 'package:near_buy_gp/features/place_screen/data/models/place_model.dart';

class PlaceCategoryModel {
  final PlaceModel place;
  final List<CategoryModel> categories;

  PlaceCategoryModel({
    required this.place,
    required this.categories,
  });
}

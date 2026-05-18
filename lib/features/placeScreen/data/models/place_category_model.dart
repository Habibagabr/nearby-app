import 'package:near_buy_gp/features/placeScreen/data/models/place_model.dart';

import 'categoryModel/category_model.dart';

class PlaceCategoryModel {
  final PlaceModel place;
  final List<CategoryModel> categories;

  PlaceCategoryModel({
    required this.place,
    required this.categories,
  });
}

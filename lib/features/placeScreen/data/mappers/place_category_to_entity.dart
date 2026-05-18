import 'package:near_buy_gp/features/placeScreen/data/mappers/category_to_entity.dart';
import 'package:near_buy_gp/features/placeScreen/data/mappers/place_model_to_entity.dart';

import '../../domain/entities/placeEntity/place_category_entity.dart';
import '../models/place_category_model.dart';

extension PlaceCategoryMapper on PlaceCategoryModel {
  PlaceCategoryEntity toEntity() {
    return PlaceCategoryEntity(
      place: place.toEntity(),
      categories: categories.map((e) => e.toEntity()).toList(),
    );
  }
}

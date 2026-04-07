import 'package:near_buy_gp/features/place_screen/data/models/category_model.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/category_entity.dart';

extension CategoryToEntity on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id?? "no",
      name: name??"no",
    );
  }
}

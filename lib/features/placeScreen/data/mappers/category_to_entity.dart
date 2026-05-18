import 'package:near_buy_gp/features/placeScreen/data/models/categoryModel/category_model.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/category_entity.dart';

extension CategoryToEntity on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id?? "",
      name: name??"",
    );
  }
}

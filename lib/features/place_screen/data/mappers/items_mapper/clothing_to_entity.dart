import '../../../domain/entities/placeEntity/itemsEntity/clothing_entity.dart';
import '../../models/attributeModels/clothing_item_attribute.dart';

extension ClothingProductMapper on ClothingProductAttributes {
  ClothingProductEntity toEntity() {
    return ClothingProductEntity(
      size: size,
      colorsAvailable: colorsAvailable,
      material: material,
      brand: brand,
      stock: stock,
    );
  }
}

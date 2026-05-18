import '../../../domain/entities/placeEntity/itemsEntity/super_market_entity.dart';
import '../../models/attributeModels/super_market_item_attribute.dart';

extension SupermarketProductMapper on SupermarketProductAttributes {
  SupermarketProductEntity toEntity() {
    return SupermarketProductEntity(
      brand: brand,
      weight: weight,
      stock: stock,
    );
  }
}

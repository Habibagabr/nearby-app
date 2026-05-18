import '../../../domain/entities/placeEntity/itemsEntity/restaurant_entity.dart';
import '../../models/attributeModels/restaurant_item_attribute.dart';

extension RestaurantItemMapper on RestaurantItemAttributes {
  RestaurantItemEntity toEntity() {
    return RestaurantItemEntity(
      menuCategory: menuCategory,
      otherMenuCategory: otherMenuCategory,
      size: size,
      tags: tags,
      isAvailable:isAvailable
    );
  }
}

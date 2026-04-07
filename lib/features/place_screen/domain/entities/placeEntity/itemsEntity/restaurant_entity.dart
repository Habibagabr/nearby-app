import '../item_attribute_entity.dart';

class RestaurantItemEntity extends ItemAttributesEntity {
  final String menuCategory;
  final String? otherMenuCategory;
  final String size;
  final List<String>? tags;

  const RestaurantItemEntity({
    required this.menuCategory,
    this.otherMenuCategory,
    required this.size,
    this.tags,
  });
}

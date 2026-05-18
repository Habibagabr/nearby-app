import '../../../domain/entities/placeEntity/itemsEntity/restaurant_entity.dart';
import 'item_attribute_model.dart';

class RestaurantItemAttributes extends ItemAttributesModel {
  final String menuCategory;
  final String? otherMenuCategory;
  final String size;
  final List<String>? tags;

  const RestaurantItemAttributes({
    required this.menuCategory,
    this.otherMenuCategory,
    required this.size,
    this.tags,
  });

  factory RestaurantItemAttributes.fromJson(Map<String, dynamic> json) {
    return RestaurantItemAttributes(
      menuCategory: json['menuCategory'],
      otherMenuCategory: json['otherMenuCategory'],
      size: json['sizes'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  @override
  RestaurantItemEntity toEntity() {
    return RestaurantItemEntity(
      menuCategory: menuCategory,
      otherMenuCategory: otherMenuCategory,
      size: size,
      tags: tags,
    );
  }
}

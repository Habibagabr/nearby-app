import 'place_entity.dart';
import 'category_entity.dart';

class PlaceCategoryEntity {
  final PlaceEntity place;
  final List<CategoryEntity> categories;

  const PlaceCategoryEntity({
    required this.place,
    required this.categories,
  });
}

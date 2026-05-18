import 'item_attribute_entity.dart';

class CategoryEntity extends ItemAttributesEntity {
  final String id;
  final String name;

  const CategoryEntity({
    required this.id,
    required this.name,
  });
}

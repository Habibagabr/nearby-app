// product_entity.dart

import 'item_attribute_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final bool isAvailable;
  final String businessId;
  final String categoryId;
  final String type;
  final ItemAttributesEntity attributes;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.isAvailable,
    required this.businessId,
    required this.categoryId,
    required this.type,
    required this.attributes,
  });
}
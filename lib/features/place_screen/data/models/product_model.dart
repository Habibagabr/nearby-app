// product_model.dart

import '../mappers/utils/items_mapper.dart';
import 'attributeModels/item_attribute_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final bool isAvailable;
  final String businessId;
  final String categoryId;
  final String type;
  final ItemAttributesModel attributes;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      isAvailable: json['isAvailable'] ?? false,
      businessId: json['businessId'],
      categoryId: json['categoryId'],
      type: json['type'],
      attributes: mapItemAttributes(
        type: json['type'],
        attributesJson: json['attributes'] ?? {},
      ),
    );
  }


}
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/itemsEntity/clothing_entity.dart';

import 'item_attribute_model.dart';

class ClothingProductAttributes extends ItemAttributesModel {
  final List<String>? size;
  final List<String>? colorsAvailable;
  final String? material;
  final String? brand;
  final int? stock;

  const ClothingProductAttributes({
    required this.size,
    this.colorsAvailable,
    this.material,
    this.brand,
    this.stock,
  });

  factory ClothingProductAttributes.fromJson(Map<String, dynamic> json) {
    return ClothingProductAttributes(
      size: json['sizes'] != null
          ? List<String>.from(json['sizes'])
          : null,

      colorsAvailable: json['colorsAvailable'] != null
          ? List<String>.from(json['colorsAvailable'])
          : null,

      material: json['material'],
      brand: json['brand'],
      stock: json['stock'],
    );
  }

  @override
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

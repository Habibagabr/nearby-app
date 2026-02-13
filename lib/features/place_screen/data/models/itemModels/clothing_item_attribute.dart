import '../item_attribute_model.dart';

class ClothingProductAttributes extends ItemAttributesModel {
  final String size;
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
      size: json['sizes'],
      colorsAvailable: json['colorsAvailable'] != null
          ? List<String>.from(json['colorsAvailable'])
          : null,
      material: json['material'],
      brand: json['brand'],
      stock: json['stock'],
    );
  }
}

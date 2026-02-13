import '../item_attribute_model.dart';

class SupermarketProductAttributes extends ItemAttributesModel {
  final String? brand;
  final String? weight;
  final int? stock;

  const SupermarketProductAttributes({
    this.brand,
    this.weight,
    this.stock,
  });

  factory SupermarketProductAttributes.fromJson(Map<String, dynamic> json) {
    return SupermarketProductAttributes(
      brand: json['brand'],
      weight: json['weight'],
      stock: json['stock'],
    );
  }
}

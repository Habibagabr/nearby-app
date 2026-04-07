import '../item_attribute_entity.dart';

class ClothingProductEntity extends ItemAttributesEntity {
  final List<String>? size;
  final List<String>? colorsAvailable;
  final String? material;
  final String? brand;
  final int? stock;

  const ClothingProductEntity({
    required this.size,
    this.colorsAvailable,
    this.material,
    this.brand,
    this.stock,
  });
}

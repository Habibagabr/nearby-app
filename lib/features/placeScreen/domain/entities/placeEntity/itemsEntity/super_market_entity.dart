import '../item_attribute_entity.dart';

class SupermarketProductEntity extends ItemAttributesEntity {
  final String? brand;
  final String? weight;
  final int? stock;

  const SupermarketProductEntity({this.brand, this.weight, this.stock});
}

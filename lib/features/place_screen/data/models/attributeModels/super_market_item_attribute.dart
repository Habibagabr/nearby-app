import '../../../domain/entities/placeEntity/itemsEntity/super_market_entity.dart';
import 'item_attribute_model.dart';

class SupermarketProductAttributes
    extends ItemAttributesModel<SupermarketProductEntity> {
  final String? brand;
  final String? weight;
  final int? stock;

  const SupermarketProductAttributes({
    this.brand,
    this.weight,
    this.stock,
  });

  factory SupermarketProductAttributes.fromJson(
      Map<String, dynamic> json) {
    return SupermarketProductAttributes(
      brand: json['brand'],
      weight: json['weight'],
      stock: (json['stock'] as num?)?.toInt(),
    );
  }

  @override
  SupermarketProductEntity toEntity() {
    return SupermarketProductEntity(
      brand: brand,
      weight: weight,
      stock: stock,
    );
  }
}
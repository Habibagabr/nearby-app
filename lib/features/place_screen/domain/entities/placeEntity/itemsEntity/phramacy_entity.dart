import '../item_attribute_entity.dart';

class PharmacyProductEntity extends ItemAttributesEntity {
  final String? brand;
  final List<String>? activeIngredients;
  final String? dosageForm;
  final String? packageSize;
  final int? stock;

  const PharmacyProductEntity({
    this.brand,
    this.activeIngredients,
    this.dosageForm,
    this.packageSize,
    this.stock,
  });
}

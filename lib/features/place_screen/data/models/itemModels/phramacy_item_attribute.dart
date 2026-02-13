import '../item_attribute_model.dart';

class PharmacyProductAttributes extends ItemAttributesModel {
  final String? brand;
  final List<String>? activeIngredients;
  final String? dosageForm;
  final String? packageSize;
  final int? stock;

  const PharmacyProductAttributes({
    this.brand,
    this.activeIngredients,
    this.dosageForm,
    this.packageSize,
    this.stock,
  });

  factory PharmacyProductAttributes.fromJson(Map<String, dynamic> json) {
    return PharmacyProductAttributes(
      brand: json['brand'],
      activeIngredients: json['activeIngredients'] != null
          ? List<String>.from(json['activeIngredients'])
          : null,
      dosageForm: json['dosageForm'],
      packageSize: json['packageSize'],
      stock: json['stock'],
    );
  }
}

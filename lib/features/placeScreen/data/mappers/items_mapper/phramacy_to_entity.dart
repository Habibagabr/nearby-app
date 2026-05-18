import '../../../domain/entities/placeEntity/itemsEntity/phramacy_entity.dart';
import '../../models/attributeModels/phramacy_item_attribute.dart';

extension PharmacyProductMapper on PharmacyProductAttributes {
  PharmacyProductEntity toEntity() {
    return PharmacyProductEntity(
      brand: brand,
      activeIngredients: activeIngredients,
      dosageForm: dosageForm,
      packageSize: packageSize,
      stock: stock,
    );
  }
}

// items_mapper.dart

import '../../models/attributeModels/clinic_item_attribute.dart';
import '../../models/attributeModels/clothing_item_attribute.dart';
import '../../models/attributeModels/phramacy_item_attribute.dart';
import '../../models/attributeModels/restaurant_item_attribute.dart';
import '../../models/attributeModels/super_market_item_attribute.dart';
import '../../models/attributeModels/class_session_attribute.dart';
import '../../models/attributeModels/gym_membership_attributes.dart';
import '../../models/attributeModels/item_attribute_model.dart';

ItemAttributesModel mapItemAttributes({
  required String type,
  required Map<String, dynamic> attributesJson,
}) {
  switch (type) {
    case "restaurant":
      return RestaurantItemAttributes.fromJson(attributesJson);

    case "clothing_product":
      return ClothingProductAttributes.fromJson(attributesJson);

    case "pharmacy_product":
      return PharmacyProductAttributes.fromJson(attributesJson);

    case "super_market_product":
    case "supermarket":
      return SupermarketProductAttributes.fromJson(attributesJson);

    case "clinic":
      return ClinicServiceAttributes.fromJson(attributesJson);

    case "gym":
      return GymMembershipAttributes.fromJson(attributesJson);

    case "class_session":
      return ClassSessionAttributes.fromJson(attributesJson);

      /// FIX ME : WE SHOULDN'T THROUGH THE EXCEPTION HERE
    default:
      throw Exception("Unknown item category type: $type");
  }
}
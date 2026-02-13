import '../../models/itemModels/class_session_attribute.dart';
import '../../models/itemModels/clinic_item_attribute.dart';
import '../../models/itemModels/clothing_item_attribute.dart';
import '../../models/itemModels/gym_membership_attributes.dart';
import '../../models/itemModels/item_attribute_model.dart';
import '../../models/itemModels/phramacy_item_attribute.dart';
import '../../models/itemModels/restaurant_item_attribute.dart';
import '../../models/itemModels/super_market_item_attribute.dart';

ItemAttributesModel mapItemAttributes({
  required String category,
  required Map<String, dynamic> attributesJson,
}) {
  switch (category) {
    case "restaurant":
      return RestaurantItemAttributes.fromJson(attributesJson);

    case "clothing":
      return ClothingProductAttributes.fromJson(attributesJson);

    case "pharmacy":
      return PharmacyProductAttributes.fromJson(attributesJson);

    case "supermarket":
      return SupermarketProductAttributes.fromJson(attributesJson);

    case "clinic":
      return ClinicServiceAttributes.fromJson(attributesJson);

    case "gym":
      return GymMembershipAttributes.fromJson(attributesJson);

    case "class":
      return ClassSessionAttributes.fromJson(attributesJson);

    default:
      throw Exception("Unknown category type: $category");
  }
}

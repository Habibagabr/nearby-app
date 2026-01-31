import 'package:near_buy_gp/features/place_screen/domain/entities/commonEntities/social_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/storeEntity/store_product.dart';

class StoreEntity {
  final String storeId;
  final String storeType;
  final List<String> storeImages;
  final String storeName;
  final int reviewsCount;
  final double rate;
  final String storeDescription;
  final List<String> availableProductsCategories;
  final List<StoreProductEntity> storeProducts;
  final List<SocialData> socialMediaLinks;
  final String address;
  final double lat;
  final double lng;
  final String phoneNumber;
  final String openingHours;
  final String closingHours;
  final bool placeStatus;

  StoreEntity({
    required this.rate,
    required this.storeType,
    required this.storeId,
    required this.storeImages,
    required this.storeName,
    required this.storeDescription,
    required this.availableProductsCategories,
    required this.storeProducts,
    required this.socialMediaLinks,
    required this.address,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.reviewsCount,
    required this.openingHours,
    required this.closingHours,
    required this.placeStatus
  });
}

import 'package:near_buy_gp/features/place_screen/domain/entities/genericEntities/amenities_enum.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/genericEntities/opening_day_hour_entity.dart';

import '../commonEntities/social_entity.dart';

class GenericEntity{
  final String genericPlaceId;
  final List<String> genericPlaceImages;
  final String genericPlaceName;
  final String genericPlaceType;
  final int reviewsCount;
  final double rate;
  final String genericPlaceDescription;
  final List<SocialData> socialMediaLinks;
  final String address;
  final double lat;
  final double lng;
  final String phoneNumber;
  final bool placeStatus;
  final List<Amenity> amenityList;
  final List<OpeningDayHour> openingDayHourList;

  GenericEntity({
    required this.rate,
    required this.genericPlaceId,
    required this.genericPlaceImages,
    required this.genericPlaceName,
    required this.genericPlaceDescription,
    required this.socialMediaLinks,
    required this.address,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.reviewsCount,
    required this.placeStatus,
    required this.genericPlaceType,
    required this.amenityList,
    required this.openingDayHourList
  });


}
import '../../../mapScreen/presentation/markers/nearby_pin_entity.dart';

class NearbyPinModel{
  final String placeName;
  final String placeCategory;
  final String placeId;
  final String placeRate;
  final bool placeState;
  final double placeLat;
  final double placeLng;

  NearbyPinModel({
    required this.placeName,
    required this.placeCategory,
    required this.placeId,
    required this.placeState,
    required this.placeRate,
    required this.placeLat,
    required this.placeLng});

  NearbyPinEntity toEntity(){
    return NearbyPinEntity(
      placeCategory: placeCategory,
      placeId: placeId,
      placeName: placeName,
      placeLat: placeLat,
      placeRate: placeRate,
      placeLng: placeLng,
      placeState: placeState
    );

  }
}
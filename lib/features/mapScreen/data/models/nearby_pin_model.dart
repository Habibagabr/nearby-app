import '../../domain/entity/nearby_pin_entity.dart';

class NearbyPinModel {
  final String placeName;
  final String placeCategory;
  final String placeId;
  final double placeRate;
  final String placeState;
  final double placeLat;
  final double placeLng;
  final int count;
  final String placeType;

  NearbyPinModel({
    required this.placeName,
    required this.placeCategory,
    required this.placeId,
    required this.placeState,
    required this.placeRate,
    required this.placeLat,
    required this.placeLng,
    required this.count,
    required this.placeType,
  });

  factory NearbyPinModel.fromJson(Map<String, dynamic> json) {
    final model = NearbyPinModel(
      count: json['count'] as int? ?? 1,
      placeName: json['name'],
      placeCategory: json['category'],
      placeId: json['id'],
      placeState: json['status'],
      placeRate: (json['rate'] as num).toDouble(),
      placeLat: (json['coordinates'][1] as num).toDouble(),
      placeLng: (json['coordinates'][0] as num).toDouble(),
      placeType: json['type'],
    );
    return model;
  }

  NearbyPinEntity toEntity() {
    return NearbyPinEntity(
      placeCategory: placeCategory,
      placeId: placeId,
      placeName: placeName,
      placeLat: placeLat,
      placeRate: placeRate,
      placeLng: placeLng,
      placeState: placeState,
      count: count,
      placeType: placeType,
    );
  }
}

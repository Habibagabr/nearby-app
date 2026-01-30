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
  NearbyPinModel({
    required this.placeName,
    required this.placeCategory,
    required this.placeId,
    required this.placeState,
    required this.placeRate,
    required this.placeLat,
    required this.placeLng,
    required this.count,
  });

  factory NearbyPinModel.fromJson(Map<String, dynamic> json) {

    final model =  NearbyPinModel(
      count: json['count'] as int? ?? 1,
      placeName: json['name'],
      placeCategory: json['category'],
      placeId: json['id'],
      placeState: json['status'],
      placeRate: (json['rate'] as num).toDouble(),
      placeLat: (json['coordinates'][1] as num).toDouble(),
      placeLng: (json['coordinates'][0] as num).toDouble(),
    );
    print(
        "MODEL: "
            "name=${model.placeName}, "
            "lat=${model.placeLat}, "
            "lng=${model.placeLng}, "
            "count=${model.count}"
    );
    return model;

  }

  NearbyPinEntity toEntity() {

    final entity =  NearbyPinEntity(
      placeCategory: placeCategory,
      placeId: placeId,
      placeName: placeName,
      placeLat: placeLat,
      placeRate: placeRate,
      placeLng: placeLng,
      placeState: placeState,
      count: count,
    );
    print(
        "ENTITY: "
            "id=${entity.placeId}, "
            "lat=${entity.placeLat}, "
            "lng=${entity.placeLng}, "
            "count=${entity.count}"
    );

    return entity;
  }
}

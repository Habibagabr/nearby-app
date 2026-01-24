import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';

class NearbyPlaceModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final double rating;
  final double lat;
  final double lng;
  final String? status = "opened";
  final List<String> imageUrls;
  final List<String>? servicesProvided;
  const NearbyPlaceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.servicesProvided,
    required this.address,
    required this.rating,
    required this.imageUrls,
    required this.lat,
    required this.lng,
  });

  NearbyPlaceEntity toEntity() {
    return NearbyPlaceEntity(
      id: id,
      name: name,
      category: category,
      description: description,
      servicesProvided: servicesProvided,
      address: address,
      rating: rating,
      imageUrls: imageUrls,
      lat: lat,
      lng: lng,
    );
  }
}

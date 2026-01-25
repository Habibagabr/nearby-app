import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';

class NearbyPlaceModel {
  final String? id;
  final String? name;
  final String? category;
  final String? description;
  final String? address;
  final double? rating;
  final double? lat;
  final double? lng;
  final String? status;
  final String? type;
  final String? mainImage; // Added to match "image": ""
  final List<String>? imageUrls;
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
    required this.status,
    required this.lat,
    required this.lng,
    required this.type,
    required this.mainImage,
  });

  factory NearbyPlaceModel.fromJson(Map<String, dynamic> json) {
    // Extracting coordinates from the List<double> in JSON
    final List<dynamic> coordinates = json['coordinates'] ?? [0.0, 0.0];

    return NearbyPlaceModel(
      id: json['id']?.toString() ?? "",
      name: json['name'] ?? "",
      category: json['category'] ?? "",
      description: json['description'] ?? "",
      servicesProvided: List<String>.from(json['tags'] ?? []),
      address: json['address'] ?? "",
      rating: (json['rate'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? "",
      imageUrls: List<String>.from(json['images'] ?? []),
      mainImage: json['image'] ?? "",
      lat: (coordinates.isNotEmpty ? (coordinates[1] as num).toDouble() : 0.0),
      lng: (coordinates.length > 1 ? (coordinates[0] as num).toDouble() : 0.0),
      type: json['type'] ?? "",
    );
  }

  NearbyPlaceEntity toEntity() {
    return NearbyPlaceEntity(
      id: id ?? "",
      name: name ?? "",
      category: category ?? "",
      description: description ?? "",
      servicesProvided: servicesProvided ?? [],
      address: address ?? "",
      rating: rating ?? 0.0,
      imageUrls: imageUrls ?? [],
      lat: lat ?? 0.0,
      lng: lng ?? 0.0,
      status: status ?? "",
      type: type ?? "",
    );
  }
}

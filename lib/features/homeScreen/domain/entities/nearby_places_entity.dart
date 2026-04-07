class NearbyPlaceEntity {
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final double rating;
  final double lat;
  final double lng;
  final String status;
  final String type;
  final List<String> imageUrls;
  final List<String> servicesProvided;
  final int count;
  final String subCategory;

  const NearbyPlaceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.servicesProvided,
    required this.address,
    required this.rating,
    required this.status,
    required this.imageUrls,
    required this.lat,
    required this.lng,
    required this.type,
    this.count =1,
    required this.subCategory
  });
}

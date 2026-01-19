class NearbyPlaceEntity{
  final String id;
  final String name;
  final String category;
  final String description;
  final String address;
  final double rating;
  final double lat;
  final double lng;
  final List<String> imageUrls;
  final List<String>? servicesProvided;
  const NearbyPlaceEntity({
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













}
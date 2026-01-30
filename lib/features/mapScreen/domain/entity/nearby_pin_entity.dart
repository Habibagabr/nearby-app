class NearbyPinEntity{
  final String placeName;
  final String placeCategory;
  final String placeId;
  final String placeRate;
  final bool placeState;
  final double placeLat;
  final double placeLng;
  NearbyPinEntity({
    required this.placeName,
    required this.placeCategory,
    required this.placeId,
    required this.placeState,
    required this.placeRate,
    required this.placeLat,
    required this.placeLng});
}
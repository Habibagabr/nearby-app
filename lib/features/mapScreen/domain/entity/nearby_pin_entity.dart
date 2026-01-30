class NearbyPinEntity{
  final String placeName;
  final String placeCategory;
  final String placeId;
  final double placeRate;
  final String placeState;
  final double placeLat;
  final double placeLng;
  final int count;

  NearbyPinEntity({
    required this.placeName,
    required this.placeCategory,
    required this.placeId,
    required this.placeState,
    required this.placeRate,
    required this.placeLat,
    required this.placeLng,
    required this.count
  });
}
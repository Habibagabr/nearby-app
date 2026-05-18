class LocationModel {
  final String? type;
  final List<double>? coordinates;

  const LocationModel({
    this.type,
    this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final rawCoordinates = json['coordinates'];

    return LocationModel(
      type: json['type'] as String?,
      coordinates: rawCoordinates is List
          ? rawCoordinates
          .whereType<num>()
          .map((e) => e.toDouble())
          .toList()
          : null,
    );
  }
}

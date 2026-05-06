class SearchResponseEntity {
  final String id;
  final String images;
  final String name;
  final double rate;
  final double distance;
  final String category;
  final bool isOpenNow;

  const SearchResponseEntity({
    required this.id,
    required this.category,
    required this.name,
    required this.isOpenNow,
    required this.rate,
    required this.images,
    required this.distance,
  });
}

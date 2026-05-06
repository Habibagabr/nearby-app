import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';

class SearchResponseModel {
  final String? id;
  final String? images;
  final String? name;
  final double? rate;
  final double? distance;
  final String? category;
  final bool? isOpenNow;

  const SearchResponseModel({
    required this.id,
    required this.category,
    required this.name,
    required this.isOpenNow,
    required this.rate,
    required this.images,
    required this.distance,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      id: (json['businessId'] as String?) ?? "0",
      name: (json['name'] as String?) ?? "",
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      distance: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      category: (json['category'] as String?) ?? "",
      isOpenNow: (json['isOpenNow'] as bool?) ?? false,
      images: (json['photo'] as String?) ?? "",
    );
  }

  SearchResponseEntity toEntity(SearchResponseModel model) {
    return SearchResponseEntity(
      id: model.id ?? "",
      category: model.category ?? "",
      name: model.name ?? "",
      isOpenNow: model.isOpenNow ?? false,
      rate: model.rate ?? 0.0,
      images: model.images ?? "",
      distance: model.distance ?? 0.0,
    );
  }
}

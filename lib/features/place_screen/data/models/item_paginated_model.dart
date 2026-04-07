// item_paginated_model.dart

import 'product_model.dart';

class ItemsPaginatedModel {
  final List<ProductModel> items;
  final int total;
  final int page;
  final int limit;

  const ItemsPaginatedModel({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory ItemsPaginatedModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List? ?? [];

    return ItemsPaginatedModel(
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map((itemJson) => ProductModel.fromJson(itemJson))
          .toList(),
      total: (json['total'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );
  }
}
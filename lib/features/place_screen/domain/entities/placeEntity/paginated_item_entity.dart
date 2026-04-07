
import 'item_attribute_entity.dart';

// paginated_item_entity.dart

import 'product_entity.dart';

class ItemsPaginatedEntity {
  final List<ProductEntity> items;
  final int total;
  final int page;
  final int limit;

  const ItemsPaginatedEntity({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory ItemsPaginatedEntity.empty() {
    return const ItemsPaginatedEntity(
      items: [],
      total: 0,
      page: 1,
      limit: 10,
    );
  }
}

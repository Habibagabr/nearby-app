import 'package:fpdart/fpdart.dart';

import '../entities/placeEntity/paginated_item_entity.dart';
import '../entities/placeEntity/place_category_entity.dart';

abstract class PlaceRepository {
  Future<Either<String, PlaceCategoryEntity>> loadInitialPlaceData(
      String placeId,
      );

  Future<Either<String, ItemsPaginatedEntity>> loadMoreItems({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  });

}

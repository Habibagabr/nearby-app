import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/place_screen/data/dataSource/places_remote_data_source.dart';
import 'package:near_buy_gp/features/place_screen/data/mappers/category_to_entity.dart';
import 'package:near_buy_gp/features/place_screen/data/mappers/place_model_extension_to_entity.dart';
import 'package:near_buy_gp/features/place_screen/data/mappers/place_model_to_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/repository/place_repository.dart';

import '../../domain/entities/placeEntity/paginated_item_entity.dart';
import '../../domain/entities/placeEntity/place_category_entity.dart';
import '../models/category_model.dart';
import '../models/place_model.dart';

@LazySingleton(as: PlaceRepository)
class PlaceRepositoryImpl implements PlaceRepository {
  final PlacesRemoteDataSource remote;

  PlaceRepositoryImpl(this.remote);

  @override
  Future<Either<String, PlaceCategoryEntity>> loadInitialPlaceData(
      String placeId,
      ) async {

    PlaceModel? placeModel;
    List<CategoryModel>? categoriesModel;

    try {
      final results = await Future.wait([
        remote.getPlace(
          placeId: placeId,
          page: 1,
          limit: 3,
        ),
        remote.getPlaceCategories(placeId),
      ]);

      placeModel = results[0] as PlaceModel;
      categoriesModel = results[1] as List<CategoryModel>;

      return Right(
        PlaceCategoryEntity(
          place: placeModel.toEntity(),
          categories: categoriesModel.map((e) => e.toEntity()).toList(),
        ),
      );

    } catch (e, stackTrace) {

      print("ERROR: $e");
      print("STACKTRACE: $stackTrace");

      return Left('Failed to load place data: $e');
    }
  }

  @override
  Future<Either<String, ItemsPaginatedEntity>> loadMoreItems({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  }) async {
    try {
      final placeModel = await remote.getPlace(
        placeId: placeId,
        page: page,
        limit: limit,
        categoryId: categoryId,
      );

      return Right(
        placeModel.itemsPaginated?.toEntity() ??
            ItemsPaginatedEntity.empty(),
      );
    } catch (e) {
      return Left('Failed to load items');
    }
  }
}


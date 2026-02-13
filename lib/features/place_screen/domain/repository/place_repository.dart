import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/features/place_screen/data/models/place_category_model.dart';

abstract class PlaceRepository{
  Future<Either<String , PlaceCategoryModel>> getPlaceData(String placeId);
}
import 'package:near_buy_gp/shared/util/screens_enum.dart';

ScreensType getPlaceScreenCategoryUseCase(String category) {
  switch (category.toLowerCase()) {
    case "store":
    case "pharmacy":
    case "clothing":
    case "restaurant":
      return ScreensType.store;
    case "clinic":
      return ScreensType.clinic;
    default:
      return ScreensType.generic;
  }
}

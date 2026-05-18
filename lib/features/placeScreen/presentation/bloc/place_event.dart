abstract class PlaceEvent {}

class EnterPlaceScreen extends PlaceEvent {
  final String placeId;

  EnterPlaceScreen(this.placeId);
}

class LoadNextPage extends PlaceEvent {
  final String? categoryId;

  LoadNextPage({this.categoryId});
}

class SelectCategory extends PlaceEvent {
  final String categoryId;

  SelectCategory(this.categoryId);
}

class SaveButtonPressed extends PlaceEvent {}

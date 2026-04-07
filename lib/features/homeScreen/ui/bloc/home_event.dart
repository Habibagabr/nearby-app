part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInit extends HomeEvent {}

class FetchNearbyPlacesEvent extends HomeEvent {
  final double lat;
  final double lng;
  final int pageNum;
  final int limit;
  final String ? businessCategory;

  FetchNearbyPlacesEvent({
    required this.lat,
    required this.lng,
    required this.pageNum,
    required this.limit,
    this.businessCategory
  });
}

class PlaceSelected extends HomeEvent {
  final String placeId;
  final String businessCategory;

  PlaceSelected({required this.placeId, required this.businessCategory});
}

class CategorySelected extends HomeEvent {
  final String businessCategory;

  CategorySelected({required this.businessCategory});
}

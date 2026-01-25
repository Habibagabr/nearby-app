part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInit extends HomeEvent {}

class FetchNearbyPlacesEvent extends HomeEvent {
  final double lat;
  final double lng;
  final int pageNum;
  final int limit ;
  FetchNearbyPlacesEvent({
    required this.lat,
    required this.lng,
    required  this.pageNum,
    required  this.limit,
  });
}

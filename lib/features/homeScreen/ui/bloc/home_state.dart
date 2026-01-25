part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

@immutable
class HomeState {
  final List<NearbyPlaceEntity> nearbyPlaces;
  final String errorMsg;
  final HomeStatus status;
  final bool isMaxReached;
  final double lat;
  final double lng;
  final int pageNum;

  const HomeState({
    this.nearbyPlaces = const [],
    this.errorMsg = '',
    this.status = HomeStatus.initial,
    this.isMaxReached = false,
    this.lat=0,
    this.lng=0,
    this.pageNum=1
  });

  // The copyWith method allows us to update specific fields while keeping others
  HomeState copyWith({
    List<NearbyPlaceEntity>? nearbyPlaces,
    String? errorMsg,
    HomeStatus? status,
    bool? isMaxReached,
    int? pageNum,
    double? lat,
    double? lng
  }) {
    return HomeState(
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      isMaxReached: isMaxReached??false,
      pageNum: pageNum??1,
      lat: lat??0.0,
      lng: lng??0.0
    );
  }
}



part of 'home_bloc.dart';

class NavigateState{
  final ScreensType screenType;
  final String placeId;
  NavigateState({
    required this.placeId,
    required this.screenType
});
}

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
  final NavigateState ? navigateState;
  final String? businessCategory;

  const HomeState({
    this.nearbyPlaces = const [],
    this.errorMsg = '',
    this.status = HomeStatus.initial,
    this.isMaxReached = false,
    this.lat=0,
    this.lng=0,
    this.pageNum=1,
    this.navigateState,
    this.businessCategory
  });

  // The copyWith method allows us to update specific fields while keeping others
  HomeState copyWith({
    List<NearbyPlaceEntity>? nearbyPlaces,
    String? errorMsg,
    HomeStatus? status,
    bool? isMaxReached,
    int? pageNum,
    double? lat,
    double? lng ,
    NavigateState ? navigateState,
    String? businessCategory,

  }) {
    return HomeState(
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      isMaxReached: isMaxReached??false,
      pageNum: pageNum?? this.pageNum,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      navigateState: navigateState,
      businessCategory: businessCategory??this.businessCategory
    );
  }
}



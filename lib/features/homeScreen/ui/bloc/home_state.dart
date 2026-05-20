part of 'home_bloc.dart';

class NavigateState {
  final ScreensType screenType;
  final String placeId;
  NavigateState({
    required this.placeId,
    required this.screenType,
  });
}

enum HomeStatus { initial, loading, success, failure, afterFailure }
enum FailureTypes { server, network, canceling, general }

@immutable
class HomeState {
  final List<NearbyPlaceEntity> nearbyPlaces;
  final String errorMsg;
  final HomeStatus status;
  final bool isMaxReached;
  final double lat;
  final double lng;
  final int pageNum;
  final NavigateState? navigateState;
  final String? businessCategory;
  final FailureTypes? failureType;
  final bool hasNetworkError; // Added to prevent unstable layout flags from hijacking connectivity hooks

  const HomeState({
    this.nearbyPlaces = const [],
    this.errorMsg = '',
    this.status = HomeStatus.initial,
    this.isMaxReached = false,
    this.lat = 0,
    this.lng = 0,
    this.pageNum = 1,
    this.navigateState,
    this.businessCategory,
    this.failureType,
    this.hasNetworkError = false, // Defaulted to safe state
  });

  HomeState copyWith({
    List<NearbyPlaceEntity>? nearbyPlaces,
    String? errorMsg,
    HomeStatus? status,
    bool? isMaxReached,
    int? pageNum,
    double? lat,
    double? lng,
    NavigateState? navigateState,
    String? businessCategory,
    FailureTypes? failureType,
    bool? hasNetworkError, // Added update parameter hook
  }) {
    return HomeState(
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      isMaxReached: isMaxReached ?? this.isMaxReached, // Fixed bug: fell back to false instead of keeping current value
      pageNum: pageNum ?? this.pageNum,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      navigateState: navigateState, // Allowed to intentionally clear down to null on route resolution completions
      businessCategory: businessCategory ?? this.businessCategory,
      failureType: failureType ?? this.failureType,
      hasNetworkError: hasNetworkError ?? this.hasNetworkError, // Map update safely here
    );
  }
}

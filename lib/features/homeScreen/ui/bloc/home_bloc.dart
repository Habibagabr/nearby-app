import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/usecases/get_nearby_places.dart';
import 'package:near_buy_gp/shared/util/screens_enum.dart';

part 'home_event.dart';

part 'home_state.dart';

@LazySingleton()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNearbyPlacesUseCase getNearbyPlacesUseCase;

  HomeBloc(this.getNearbyPlacesUseCase) : super(HomeState()) {
    on<FetchNearbyPlacesEvent>(_onFetchNearbyPlaces);
    on<PlaceSelected>((event, emit) {
      (_onPlaceSelected(
        placeId: event.placeId,
        businessCategory: event.businessCategory,
        emit: emit,
      ));
    });
    on<CategorySelected>((event, emit)async {
      await (_onCategorySelected(
        businessCategory: event.businessCategory,
        emit: emit,
      ));
    });
  }

  Future<void> _onCategorySelected({
    required String businessCategory,
    required Emitter<HomeState> emit,
  }) async {
    emit(
      state.copyWith(
        businessCategory: businessCategory,
        pageNum: 1,
        nearbyPlaces: [],
        isMaxReached: false,
      ),
    );

    final fetchEvent = FetchNearbyPlacesEvent(
      lat: state.lat,
      lng: state.lng,
      pageNum: 1,
      limit: 5,
      businessCategory: businessCategory,
    );

    await _onFetchNearbyPlaces(fetchEvent, emit);
  }

  void _onPlaceSelected({
    required String businessCategory,
    required String placeId,
    required Emitter<HomeState> emit,
  }) {
    final String category = businessCategory.toLowerCase() ;

    if (category == "store" ||
        category == "restaurant" ||
        category == "clothing" ||
        category == "pharmacy") {
      emit(
        state.copyWith(
          navigateState: NavigateState(
            placeId: placeId,
            screenType: ScreensType.store,
          ),
        ),
      );
    } else if (category == "clinic") {
      emit(
        state.copyWith(
          navigateState: NavigateState(
            placeId: placeId,
            screenType: ScreensType.clinic,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          navigateState: NavigateState(
            placeId: placeId,
            screenType: ScreensType.generic,
          ),
        ),
      );
    }

    // Clear the navigation action immediately so it doesn't trigger again
    emit(state.copyWith(navigateState: null));
  }



  Future<void> _onFetchNearbyPlaces(
    FetchNearbyPlacesEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Avoid clearing existing data when fetching page 2+
    // We only set status to 'loading' so the UI shows the bottom spinner.
    emit(state.copyWith(status: HomeStatus.loading));
// Inside HomeBloc _onFetchNearbyPlaces
    final result = await getNearbyPlacesUseCase(
      lat: event.lat,
      lng: event.lng,
      pageNum: event.pageNum,
      limit: event.limit,
      businessCategory: event.businessCategory?.toLowerCase() == "all" ? null : event.businessCategory?.toLowerCase().replaceAll(" ", "_"), // Send the mapped value (store, gym, etc.)
    );


    result.fold(
      (error) =>
          emit(state.copyWith(status: HomeStatus.failure, errorMsg: error.failureMessage , failureType: mapFailureType(error))),
      (newPlaces) {
        // APPEND DATA
        // If pageNum is 1, it's a fresh start. Otherwise, we add newPlaces to the old ones.
        final List<NearbyPlaceEntity> updatedList = event.pageNum == 1
            ? newPlaces
            : [...state.nearbyPlaces, ...newPlaces];

        //  REFINED MAX REACHED LOGIC
        // If the API returns fewer items than the 'limit', we know there is no more data left.
        final bool reachedMax = newPlaces.length < event.limit;

        emit(
          state.copyWith(
            status: HomeStatus.success,
            errorMsg: null,
            failureType: null,
            nearbyPlaces: updatedList,
            isMaxReached: reachedMax,
            lng: event.lng,
            lat: event.lat,
            pageNum: event.pageNum,
          ),
        );
      },
    );
  }

  FailureTypes? mapFailureType(AppFailure error) {
    return switch(error){

      NetworkFailure() => FailureTypes.network,
      ServerFailure() => FailureTypes.server,
      CancelFailure() => null,
      GeneralFailure() => FailureTypes.general,
    };
  }
}

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/features/homeScreen/domain/entities/nearby_places_entity.dart';
import 'package:near_buy_gp/features/homeScreen/domain/usecases/get_nearby_places.dart';

part 'home_event.dart';
part 'home_state.dart';

@LazySingleton()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNearbyPlacesUseCase getNearbyPlacesUseCase;

  HomeBloc(this.getNearbyPlacesUseCase) : super(HomeState()) {
    on<FetchNearbyPlacesEvent>(_onFetchNearbyPlaces);
  }

  Future<void> _onFetchNearbyPlaces(
      FetchNearbyPlacesEvent event,
      Emitter<HomeState> emit,
      ) async {
    // Avoid clearing existing data when fetching page 2+
    // We only set status to 'loading' so the UI shows the bottom spinner.
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await getNearbyPlacesUseCase(
      lat: event.lat,
      lng: event.lng,
      pageNum: event.pageNum,
      limit: event.limit,
    );

    result.fold(
          (error) => emit(state.copyWith(status: HomeStatus.failure, errorMsg: error)),
          (newPlaces) {
        // APPEND DATA
        // If pageNum is 1, it's a fresh start. Otherwise, we add newPlaces to the old ones.
        final List<NearbyPlaceEntity> updatedList = event.pageNum == 1
            ? newPlaces
            : [...state.nearbyPlaces, ...newPlaces];

        //  REFINED MAX REACHED LOGIC
        // If the API returns fewer items than the 'limit', we know there is no more data left.
        final bool reachedMax = newPlaces.length < event.limit;

        emit(state.copyWith(
          status: HomeStatus.success,
          nearbyPlaces: updatedList,
          isMaxReached: reachedMax,
          lng: event.lng,
          lat: event.lat,
          pageNum: event.pageNum,
        ));
      },
    );
  }
}

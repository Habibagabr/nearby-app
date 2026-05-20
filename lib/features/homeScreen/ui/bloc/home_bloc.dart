import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
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
  StreamSubscription? _connectivitySubscription;

  HomeBloc(this.getNearbyPlacesUseCase) : super(HomeState()) {
    on<FetchNearbyPlacesEvent>(_onFetchNearbyPlaces);
    on<PlaceSelected>((event, emit) {
      _onPlaceSelected(
        placeId: event.placeId,
        businessCategory: event.businessCategory,
        emit: emit,
      );
    });
    on<CategorySelected>((event, emit) async {
      await _onCategorySelected(
        businessCategory: event.businessCategory,
        emit: emit,
      );
    });

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final isOnline = !results.contains(ConnectivityResult.none);

      // Check explicit error tracking state instead of volatile status flags
      if (isOnline && state.hasNetworkError) {
        if (state.lat != 0 || state.lng != 0) {
          // If 1st page failed, request page 1. If subsequent pages failed, retry that exact page
          final recoveryPage = state.nearbyPlaces.isEmpty
              ? 1
              : state.pageNum + 1;

          add(
            FetchNearbyPlacesEvent(
              lat: state.lat,
              lng: state.lng,
              pageNum: recoveryPage,
              limit: 3,
              businessCategory: state.businessCategory,
            ),
          );
        }
      }
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
        status: HomeStatus.loading,
        hasNetworkError:
            false,
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
    final String category = businessCategory.toLowerCase();

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
    emit(state.copyWith(navigateState: null));
  }

  Future<void> _onFetchNearbyPlaces(
    FetchNearbyPlacesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final List<NearbyPlaceEntity> historicalPlaces = List.from(
      state.nearbyPlaces,
    );

    emit(
      state.copyWith(
        status: HomeStatus.loading,
        lat: event.lat,
        lng: event.lng,
        hasNetworkError: false,
      ),
    );

    final result = await getNearbyPlacesUseCase(
      lat: event.lat,
      lng: event.lng,
      pageNum: event.pageNum,
      limit: event.limit,
      businessCategory: event.businessCategory?.toLowerCase() == "all"
          ? null
          : event.businessCategory?.toLowerCase().replaceAll(" ", "_"),
    );

    result.fold(
      (error) {
        if (kDebugMode) {
          print("PRINT:HOME SCREEN : ERROR TYPE ${mapFailureType(error)}");
        }

        emit(
          state.copyWith(
            status: HomeStatus.failure,
            hasNetworkError: true,
            // Marked to catch auto-recovery cycles
            errorMsg: error.failureMessage,
            failureType: mapFailureType(error),
            lat: event.lat,
            lng: event.lng,
          ),
        );
      },
      (newPlaces) {
        final List<NearbyPlaceEntity> updatedList = event.pageNum == 1
            ? newPlaces
            : [...historicalPlaces, ...newPlaces];

        final bool reachedMax = newPlaces.length < event.limit;

        emit(
          state.copyWith(
            status: HomeStatus.success,
            hasNetworkError: false,
            // Reset cleanly on network resolution success
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
    return switch (error) {
      NetworkFailure() => FailureTypes.network,
      ServerFailure() => FailureTypes.server,
      CancelFailure() => null,
      GeneralFailure() => FailureTypes.general,
    };
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:near_buy_gp/core/location/location_service.dart';
import '../../../core/location/location_permission_status.dart';
import 'package:geolocator/geolocator.dart'; // REQUIRED IMPORT

part 'location_event.dart';
part 'location_state.dart';


class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? _serviceStatusSub;

  LocationBloc() : super(LocationInitial()) {
    on<StartLocationTracking>(_onStartTracking);

    // Listen to GPS Hardware toggle (On/Off) immediately
    _serviceStatusSub = LocationService.serviceStatusStream.listen((status) {
      if (status == ServiceStatus.disabled) {
         emit(LocationServiceDisabled());
      }
    });
  }

  Future<void> _onStartTracking(
      StartLocationTracking event,
      Emitter<LocationState> emit,
      ) async {
    emit(LocationLoading());

    final status = await LocationService.handlePermission();

    if (status != LocationPermissionStatus.granted) {
      if (status == LocationPermissionStatus.serviceDisabled) emit(LocationServiceDisabled());
      if (status == LocationPermissionStatus.denied) emit(LocationPermissionDenied());
      if (status == LocationPermissionStatus.deniedForever) emit(LocationPermissionDeniedForever());
      return;
    }

    // Get initial position once
    final initialPos = await LocationService.getCurrentLocation();
    emit(LocationReady(lat: initialPos.latitude, lng: initialPos.longitude));

    // Bind stream to state
    return emit.forEach<Position>(
      LocationService.locationStream(),
      onData: (Position position) {
        if (kDebugMode) print("Location updated: ${position.latitude}");
        return LocationReady(lat: position.latitude, lng: position.longitude);
      },
      onError: (error, stack) {
        return LocationInitial();
      },
    );
  }

  @override
  Future<void> close() {
    _serviceStatusSub?.cancel();
    return super.close();
  }
}

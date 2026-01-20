import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../location/presentation/bloc/location_event.dart';
import '../../../location/presentation/bloc/location_state.dart';
import '../../domain/entities/user_location_entity.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/initialize_location_usecase.dart';
import '../../domain/usecases/watch _GPS_servicestatus_usecase.dart';
import '../../domain/usecases/watch_user_location _usecase.dart';


@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final InitializeLocation _initializeLocation;
  final WatchUserLocation _watchUserLocation;
  final WatchGpsStatus _watchGpsStatus;
  final GetCurrentLocation _getCurrentLocation;

  LocationBloc(
      this._initializeLocation,
      this._watchUserLocation,
      this._watchGpsStatus,
      this._getCurrentLocation,
      ) : super(LocationState.initial()) {

    on<RequestPermission>(_onPermissionRequested);
    on<StartTracking>(_onStartTracking);
    on<StopTracking>(_onStopTracking);
    on<UpdateLocation>(_onLocationReceived);
    on<UpdateServiceStatus>(_onServiceStatusChanged);

    // Initialize GPS Hardware Listener immediately
    _initServiceListener();
  }

  void _initServiceListener() {
    // We use emit.forEach inside an event handler to manage this properly
    add(UpdateServiceStatus(true));
  }

  Future<void> _onPermissionRequested(RequestPermission event, Emitter<LocationState> emit) async {
    emit(state.copyWith(status: LocationStatus.loading));

    final result = await _initializeLocation();

    await result.fold(
          (error) async => emit(state.copyWith(status: LocationStatus.permissionDenied, errorMessage: error)),
          (_) async {
        // Success: Get immediate snapshot then start stream
        final currentPos = await _getCurrentLocation();
        currentPos.fold(
              (_) => null, // Ignore error, stream will catch up
              (loc) => emit(state.copyWith(status: LocationStatus.tracking, location: loc)),
        );
        add(StartTracking());
      },
    );
  }

  Future<void> _onStartTracking(StartTracking event, Emitter<LocationState> emit) async {
    // emit.forEach is the standard way to handle Streams in Bloc 8.0+
    await emit.forEach<UserLocationEntity>(
      _watchUserLocation(),
      onData: (location) => state.copyWith(
        status: LocationStatus.tracking,
        location: location,
      ),
      onError: (error, _) => state.copyWith(
        status: LocationStatus.error,
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> _onServiceStatusChanged(UpdateServiceStatus event, Emitter<LocationState> emit) async {
    await emit.forEach<bool>(
      _watchGpsStatus(),
      onData: (isEnabled) {
        if (!isEnabled) {
          return state.copyWith(status: LocationStatus.serviceDisabled);
        } else if (state.status == LocationStatus.serviceDisabled) {
          // If they turn GPS back on, re-initialize
          add(RequestPermission());
        }
        return state;
      },
    );
  }

  void _onLocationReceived(UpdateLocation event, Emitter<LocationState> emit) {
    emit(state.copyWith(status: LocationStatus.tracking, location: event.location));
  }

  void _onStopTracking(StopTracking event, Emitter<LocationState> emit) {
    emit(LocationState.initial());
  }
}

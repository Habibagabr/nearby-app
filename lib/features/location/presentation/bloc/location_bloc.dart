// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:near_buy_gp/core/location/data/datasource/location_service_impl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../core/location/Location_permission_status.dart';
// import '../../../homeScreen/ui/home_screen.dart';
// import 'location_state.dart';
//
// part 'location_event.dart';
//
// final Set<Marker> _placeMarkers = nearbyPlacesMock.map((place) {
//   return Marker(
//     markerId: MarkerId(place.id),
//     position: LatLng(place.lat, place.lng),
//     infoWindow: InfoWindow(title: place.name),
//   );
// }).toSet();
//
// class LocationBloc extends Bloc<LocationEvent, LocationState> {
//   StreamSubscription? _serviceStatusSub;
//
//   LocationBloc() : super(LocationInitial()) {
//     on<StartLocationTracking>(_onStartTracking);
//
//     // Listen to GPS Hardware toggle (On/Off) immediately
//     _serviceStatusSub = LocationService.serviceStatusStream.listen((status) {
//       if (status == ServiceStatus.disabled) {
//         emit(LocationServiceDisabled());
//       }
//     });
//   }
//   // location_bloc.dart - Update to the _onStartTracking method
//   Future<void> _onStartTracking(
//     StartLocationTracking event,
//     Emitter<LocationState> emit,
//   ) async {
//     emit(LocationLoading());
//
//     final status = await LocationService.handlePermission();
//
//     if (status == LocationPermissionStatus.denied) {
//       emit(LocationError(error: "Location permission denied"));
//       return;
//     }
//
//     if (status == LocationPermissionStatus.deniedForever) {
//       emit(
//         LocationError(
//           error: "Permission permanently denied. Please enable in settings.",
//         ),
//       );
//       return;
//     }
//
//     try {
//       // Get initial position quickly
//       final initialPos = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );
//
//       emit(
//         LocationReady(
//           lat: initialPos.latitude,
//           lng: initialPos.longitude,
//           markers: _placeMarkers,
//         ),
//       );
//
//       // Subscribe to the stream for continuous updates
//       await emit.forEach<Position>(
//         LocationService.locationStream(), // Use the stream from your service
//         onData: (position) => LocationReady(
//           lat: position.latitude,
//           lng: position.longitude,
//           markers: _placeMarkers,
//         ),
//         onError: (error, stack) => LocationError(error: "Stream Error: $error"),
//       );
//     } catch (e) {
//       emit(LocationError(error: "Could not fetch location: $e"));
//     }
//   }
//
//   @override
//   Future<void> close() {
//     _serviceStatusSub?.cancel();
//     return super.close();
//   }
// }

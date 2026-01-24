import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_bloc.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_state.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/markers/marker_cache.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/markers/nearby_pin_entity.dart';

import '../../../core/location/presentation/bloc/location_bloc.dart';
import '../../../core/location/presentation/bloc/location_event.dart';
import '../../../core/location/presentation/bloc/location_state.dart';
import '../../mapScreen/presentation/bloc/map_event.dart';
import '../../mapScreen/presentation/markers/data_to_marker_mapper.dart';
import 'components/center_msg_error.dart';
import 'components/draggable_nearby_places.dart';

final List<NearbyPinEntity> pins = [
  NearbyPinEntity(
    placeId: '1',
    placeName: 'Daily Cafe',
    placeCategory: 'cafe',
    placeRate: '4.5',
    placeState: true,
    placeLat: 29.96020,
    placeLng: 31.03050,
  ),
  NearbyPinEntity(
    placeId: '2',
    placeName: 'Urban Wear',
    placeCategory: 'clothing',
    placeRate: '4.3',
    placeState: true,
    placeLat: 29.959156356469357,
    placeLng:  31.02907002649949,
  ),
  NearbyPinEntity(
    placeId: '3',
    placeName: 'Health Pharmacy',
    placeCategory: 'pharmacy',
    placeRate: '4.7',
    placeState: true,
    placeLat: 29.96040,
    placeLng: 31.03070,
  ),
  NearbyPinEntity(
    placeId: '4',
    placeName: 'Fit Gym',
    placeCategory: 'gym',
    placeRate: '4.6',
    placeState: true,
    placeLat: 29.96000,
    placeLng: 31.03100,
  ),
  NearbyPinEntity(
    placeId: '5',
    placeName: 'Fresh Market',
    placeCategory: 'market',
    placeRate: '4.2',
    placeState: true,
    placeLat: 29.95980,
    placeLng: 31.03080,
  ),
  NearbyPinEntity(
    placeId: '6',
    placeName: 'Tech Zone',
    placeCategory: 'electronics',
    placeRate: '4.4',
    placeState: true,
    placeLat: 29.96060,
    placeLng: 31.03030,
  ),
  NearbyPinEntity(
    placeId: '7',
    placeName: 'Beauty Lounge',
    placeCategory: 'salon',
    placeRate: '4.8',
    placeState: true,
    placeLat: 29.96010,
    placeLng: 31.02990,
  ),
  NearbyPinEntity(
    placeId: '8',
    placeName: 'Auto Care',
    placeCategory: 'car',
    placeRate: '4.1',
    placeState: true,
    placeLat: 29.95970,
    placeLng: 31.03040,
  ),
  NearbyPinEntity(
    placeId: '9',
    placeName: 'Medical Lab',
    placeCategory: 'lab',
    placeRate: '4.9',
    placeState: true,
    placeLat: 29.96030,
    placeLng: 31.03090,
  ),
  NearbyPinEntity(
    placeId: '10',
    placeName: 'Book Store',
    placeCategory: 'books',
    placeRate: '4.0',
    placeState: true,
    placeLat: 29.95995,
    placeLng: 31.03060,
  ),
];

Future<void> preloadMarkerIcons(BuildContext context) async {
  final List<String> iconPaths = [
    'assets/images/markers/cafe.png',
    'assets/images/markers/gym.png',
    'assets/images/markers/default.png',
  ];

  // Start all precaching tasks simultaneously
  await Future.wait(
      iconPaths.map((path) => precacheImage(AssetImage(path), context))
  );
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    /// Start location flow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationBloc>().add(RequestPermission());
      preloadMarkerIcons(context);

    });
  }

  Future<void> _onCameraIdle() async {
    final bounds = await _mapController.getVisibleRegion();
    if (!mounted) return;
    context.read<MapBloc>().add(
      ViewportChanged(
        north: bounds.northeast.latitude,
        south: bounds.southwest.latitude,
        east: bounds.northeast.longitude,
        west: bounds.southwest.longitude,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<MapBloc, MapState>(
        listenWhen: (prev , curr) => prev.places!=curr.places,
        listener: (context, state) {
          _buildMarkers(pins);
        },
        child: Stack(
          children: [
            Positioned.fill(child: _buildMap()),
            buildDraggableSheet(),
          ],
        ),
      ),
    );
  }


  // ================= MAP =================

  Widget _buildMap() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        // Tracking
        if (state.status == LocationStatus.tracking && state.location != null) {
          final lat = state.location!.latitude;
          final lng = state.location!.longitude;

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 15,
            ),
            onMapCreated: (controller) async{
              _mapController = controller;
              await _buildMarkers(pins);

            },
            onCameraIdle: _onCameraIdle,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            markers: _markers,
          );
        }

        //  GPS OFF
        if (state.status == LocationStatus.serviceDisabled) {
          return buildCenterMessage("Please enable GPS from device settings");
        }

        // 🔐Permission denied
        if (state.status == LocationStatus.permissionDenied) {
          return buildCenterMessage("Location permission is required");
        }

        //  Error
        if (state.status == LocationStatus.error) {
          return buildCenterMessage(
            state.errorMessage ?? "Unknown error",
            isError: true,
          );
        }

        //  Loading / Initial
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _buildMarkers(List<NearbyPinEntity> places) async {
    final markerFutures = places.map((place) => MarkerMapper.toMarker(place));
    final List<Marker> markerList = await Future.wait(markerFutures);

    setState(() {
      _markers = markerList.toSet();
    });
  }


}

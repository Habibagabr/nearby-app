import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_bloc.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_state.dart';

import '../../../core/di/injection.dart';
import '../../../core/location/presentation/bloc/location_bloc.dart';
import '../../../core/location/presentation/bloc/location_event.dart';
import '../../../core/location/presentation/bloc/location_state.dart';
import '../../mapScreen/presentation/bloc/map_event.dart';
import 'components/center_msg_error.dart';
import 'components/draggable_nearby_places.dart';


Future<void> preloadMarkerIcons(BuildContext context) async {
  final List<String> iconPaths = [
    'assets/images/markers/cafe.png',
    'assets/images/markers/gym.png',
    'assets/images/markers/default.png',
  ];

  // Start all precaching tasks simultaneously
  await Future.wait(
    iconPaths.map((path) => precacheImage(AssetImage(path), context)),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;
  double _currentZoom = 18;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationBloc>().add(RequestPermission());
      if (mounted) {
        preloadMarkerIcons(context);
      }
    });
  }

  Future<void> _onCameraIdle() async {
    final bounds = await _mapController.getVisibleRegion();
    if (!mounted) return;

    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    context.read<MapBloc>().add(
      FetchMapData(
        bounds: bounds,
        zoom: _currentZoom,
        center: center
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MultiBlocListener(
          listeners: [
            BlocListener<LocationBloc, LocationState>(
              listenWhen: (p, c) => p.location != c.location,
              listener: (context, state) {
                if (state.location == null) return;

                context.read<HomeBloc>().add(
                  FetchNearbyPlacesEvent(
                    lat: state.location!.latitude,
                    lng: state.location!.longitude,
                    pageNum: 1,
                    limit: 10,
                  ),
                );
              },
            ),
          ],
          child: Stack(
            children: [
              Positioned.fill(child: _buildMap()),
              const DraggableNearbyPlacesSheet(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= MAP =================

  Widget _buildMap() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        if (locationState.status == LocationStatus.tracking &&
            locationState.location != null) {
          final lat = locationState.location!.latitude;
          final lng = locationState.location!.longitude;

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: _currentZoom,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onCameraMove: (position) {
                  _currentZoom = position.zoom;
                },
                onCameraIdle: _onCameraIdle,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                markers: mapState.currentMarkers,
              );
            },
          );
        }

        if (locationState.status == LocationStatus.serviceDisabled) {
          return buildCenterMessage("Please enable GPS from device settings");
        }

        if (locationState.status == LocationStatus.permissionDenied) {
          return buildCenterMessage("Location permission is required");
        }

        if (locationState.status == LocationStatus.error) {
          return buildCenterMessage(
            locationState.errorMessage ?? "Unknown error",
            isError: true,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

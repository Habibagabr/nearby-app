import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart';
import 'package:near_buy_gp/features/homeScreen/ui/components/category_item.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_bloc.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_state.dart';

import '../../../core/location/presentation/bloc/location_bloc.dart';
import '../../../core/location/presentation/bloc/location_event.dart'; // 🌟 Added import for events
import '../../../core/location/presentation/bloc/location_state.dart';
import '../../../core/routing/app_routes.dart';
import '../../../shared/util/business_category.dart';
import '../../mapScreen/presentation/bloc/map_event.dart';
import 'components/center_msg_error.dart';
import 'components/home_screen_header.dart';
import 'widget/draggable_nearby_places.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//  Added WidgetsBindingObserver mixin to track background/foreground state transitions
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  GoogleMapController? _mapController;
  bool isFirstScreenMove = false;
  double _currentZoom = 18;
  String categorySelected = businessCategories[0].display;
  LatLngBounds? bounds;
  LatLng? center;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
      this,
    ); // Safely clean observer out of system memory
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final locationBloc = context.read<LocationBloc>();

      // If previous status was stuck on denied or error, re-check instantly on return
      if (locationBloc.state.status == LocationStatus.permissionDenied ||
          locationBloc.state.status == LocationStatus.serviceDisabled) {
        locationBloc.add(RequestPermission());
      }
    }
  }

  Future<void> _onCameraIdle() async {
    if (_mapController == null || !mounted) return;

    try {
      final currentBounds = await _mapController!.getVisibleRegion();

      final calculatedCenter = LatLng(
        (currentBounds.northeast.latitude + currentBounds.southwest.latitude) /
            2,
        (currentBounds.northeast.longitude +
                currentBounds.southwest.longitude) /
            2,
      );

      setState(() {
        bounds = currentBounds;
        center = calculatedCenter;
      });

      final apiValue = businessCategories
          .firstWhere((item) => item.display == categorySelected)
          .apiValue;

      context.read<MapBloc>().add(
        FetchMapData(
          bounds: currentBounds,
          zoom: _currentZoom,
          center: calculatedCenter,
          businessType: categorySelected == businessCategories[0].display
              ? null
              : apiValue,
        ),
      );
    } catch (e) {
      debugPrint("Map controller initialization guard caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listenWhen: (prev, curr) =>
                curr.navAction != prev.navAction && curr.navAction != null,
            listener: (context, state) {
              final action = state.navAction!;
              PlaceDetailsRoute(
                placeId: action.placeId,
                screensType: action.screenType,
              ).push(context);
            },
          ),
          BlocListener<LocationBloc, LocationState>(
            listenWhen: (prev, curr) {
              if (prev.status != LocationStatus.tracking &&
                  curr.status == LocationStatus.tracking) {
                return true;
              }
              if (prev.location == null || curr.location == null) return false;
              return prev.location!.latitude != curr.location!.latitude ||
                  prev.location!.longitude != curr.location!.longitude;
            },
            listener: (context, state) {
              if (state.location == null) return;

              final currentCategory = context
                  .read<HomeBloc>()
                  .state
                  .businessCategory;

              context.read<HomeBloc>().add(
                FetchNearbyPlacesEvent(
                  lat: state.location!.latitude,
                  lng: state.location!.longitude,
                  pageNum: 1,
                  limit: 10,
                  businessCategory: currentCategory,
                ),
              );
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen: (prev, curr) =>
                prev.navigateState != curr.navigateState &&
                curr.navigateState != null,
            listener: (context, state) {
              final nav = state.navigateState!;

              PlaceDetailsRoute(
                placeId: nav.placeId,
                screensType: nav.screenType,
              ).push(context);
            },
          ),
        ],
        child: Stack(
          children: [
            Positioned.fill(child: _buildMap()),
            HomeScreenHeader(),
            Container(
              height: 50,
              margin: EdgeInsetsGeometry.directional(top: 100),
              child: ListView.builder(
                itemCount: businessCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = businessCategories[index];
                  final isSelected = categorySelected == category.display;

                  return CategoryItem(
                    categoryName: category.display,
                    categoryIcon: category.icon,
                    isSelected: isSelected,
                    onTap: () {
                      if (categorySelected != category.display) {
                        final selectedDisplay = category.display;
                        final selectedApiValue = category.apiValue;

                        setState(() {
                          categorySelected = category.display;
                        });

                        if (bounds != null && center != null) {
                          context.read<MapBloc>().add(
                            FetchMapData(
                              bounds: bounds!,
                              zoom: _currentZoom,
                              center: center!,
                              businessType:
                                  selectedDisplay ==
                                      businessCategories[0].display
                                  ? null
                                  : selectedApiValue,
                            ),
                          );
                        }

                        context.read<HomeBloc>().add(
                          CategorySelected(businessCategory: category.apiValue),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            DraggableNearbyPlacesSheet(),
          ],
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
                  _onCameraIdle();
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

        if (locationState.status == LocationStatus.serviceDisabled ||
            locationState.status == LocationStatus.permissionDenied) {
          return buildCenterMessage(
            "Please enable GPS from device settings",
            imageUrl: "assets/images/mapbackground.webp",
          );
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

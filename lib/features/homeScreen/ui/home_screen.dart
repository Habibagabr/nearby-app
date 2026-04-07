import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart';
import 'package:near_buy_gp/features/homeScreen/ui/components/category_item.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_bloc.dart';
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_state.dart';

import '../../../core/location/presentation/bloc/location_bloc.dart';
import '../../../core/location/presentation/bloc/location_state.dart';
import '../../../core/routing/app_routes.dart';
import '../../mapScreen/presentation/bloc/map_event.dart';
import '../domain/entities/business_category.dart';
import 'components/center_msg_error.dart';
import 'components/draggable_nearby_places.dart';
import 'components/home_screen_header.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;
  bool isFirstScreenMove = false;
  double _currentZoom = 18;
  String categorySelected = businessCategories[0].display;

  Future<void> _onCameraIdle() async {
    final bounds = await _mapController.getVisibleRegion();
    if (!mounted) return;

    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    context.read<MapBloc>().add(
      FetchMapData(bounds: bounds, zoom: _currentZoom, center: center),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listenWhen: (prev, curr) => curr.navAction != null,
            listener: (context, state) {
              final action = state.navAction;

              if (action is NavigateToStoreDetails) {
                PlaceDetailsRoute(
                  placeId: action.placeId,
                  screensType: action.screensType,
                ).push(context);
                ;
              } else if (action is NavigateToServiceDetails) {
                PlaceDetailsRoute(
                  placeId: action.placeId,
                  screensType: action.screensType,
                ).push(context);
              } else if (action is NavigateToGeneralDetails) {
                PlaceDetailsRoute(
                  placeId: action.placeId,
                  screensType: action.screensType,
                ).push(context);

              }
            },
          ),
          BlocListener<LocationBloc, LocationState>(
            listenWhen: (prev, curr) {
              if (prev.location == null || curr.location == null) return false;
              return prev.location!.latitude != curr.location!.latitude ||
                  prev.location!.longitude != curr.location!.longitude;
            },
            listener: (context, state) {
              // Get the current category from the HomeBloc state
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
                  businessCategory:
                      currentCategory, // Pass the current category here!
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
                  // Check if this specific category is the one selected
                  final isSelected = categorySelected == category.display;

                  return CategoryItem(
                    categoryName: category.display,
                    categoryIcon: category.icon,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        categorySelected = category.display;
                      });

                      context.read<HomeBloc>().add(
                        CategorySelected(businessCategory: category.apiValue),
                      );
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
          return buildCenterMessage(
            "Please enable GPS from device settings",
            imageUrl: "assets/images/mapbackground.jpg",
          );
        }

        if (locationState.status == LocationStatus.permissionDenied) {
          return buildCenterMessage(
            "Please enable GPS from device settings",
            imageUrl: "assets/images/mapbackground.jpg",
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

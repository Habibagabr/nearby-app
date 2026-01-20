import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';
import 'package:near_buy_gp/features/location/presentation/resources/assests_cach.dart';

import '../../../core/location/presentation/bloc/location_bloc.dart';
import '../../../core/location/presentation/bloc/location_event.dart';
import '../../../core/location/presentation/bloc/location_state.dart';
import '../../../shared/components/header_text_style.dart';
import '../domain/entities/nearby_places_entity.dart';
import 'components/nearby_place_card.dart';

const List<NearbyPlaceEntity> nearbyPlacesMock = [
  NearbyPlaceEntity(
    id: '1',
    name: 'Costa Coffee',
    category: 'cafe',
    description:
        'International coffee shop offering premium coffee and desserts.',
    address: 'Mall of Egypt, 6th of October',
    rating: 4.5,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Coffee', 'Desserts', 'Wi-Fi', 'Takeaway'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '2',
    name: 'McDonald’s',
    category: 'cafe',
    description: 'Popular fast food restaurant serving burgers and fries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.2,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Burgers', 'Delivery', 'Kids Meals'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '3',
    name: 'City Pharmacy',
    category: 'cafe',
    description: '24/7 pharmacy providing medicines and health products.',
    address: 'Haram Street, Giza',
    rating: 4.6,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Medicines', 'Medical Supplies', 'Home Delivery'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '4',
    name: 'Gold’s Gym',
    category: 'cafe',
    description: 'Fully equipped gym with professional trainers.',
    address: 'October Plaza, 6th of October',
    rating: 4.7,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: [
      'Personal Training',
      'Fitness Classes',
      'Nutrition Advice',
    ],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '5',
    name: 'Pizza Hut',
    category: 'cafe',
    description: 'Pizza restaurant offering dine-in and delivery options.',
    address: 'Faisal Street, Giza',
    rating: 4.1,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Pizza', 'Delivery', 'Dine-in'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '6',
    name: 'Orange Mobile Store',
    category: 'cafe',
    description: 'Official Orange store for mobile services and devices.',
    address: 'Mall of Arabia, Giza',
    rating: 4.3,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['SIM Cards', 'Mobile Phones', 'Customer Support'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '7',
    name: 'Royal Beauty Salon',
    category: 'cafe',
    description: 'Professional beauty salon for hair and skincare.',
    address: 'Dokki, Giza',
    rating: 4.8,
    imageUrls: ['https://example.com/salon1.jpg'],
    servicesProvided: ['Hair Styling', 'Makeup', 'Skin Care'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '8',
    name: 'Car Care Center',
    category: 'cafe',
    description: 'Car wash and maintenance services.',
    address: 'Ring Road, Giza',
    rating: 4.0,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Car Wash', 'Oil Change', 'Tire Services'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '9',
    name: 'Alpha Medical Lab',
    category: 'cafe',
    description: 'Medical laboratory providing diagnostic tests.',
    address: 'Mohandessin, Giza',
    rating: 4.9,
    imageUrls: ['https://example.com/lab1.jpg'],
    servicesProvided: ['Blood Tests', 'PCR Tests', 'Home Visit'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
  ),

  NearbyPlaceEntity(
    id: '10',
    name: 'Spinneys Market',
    category: 'cafe',
    description: 'Supermarket offering fresh food and groceries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.4,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Groceries', 'Fresh Produce', 'Online Ordering'],
    lat: 29.961281408621428,
    lng: 31.04866114616476,
  ),
];


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapCompleter = Completer();
  bool _isFirstCameraMove = true;
  String? _mapStyle;

  @override
  void initState() {
    super.initState();

    /// Load marker icons
    MarkerIconsCache.instance.loadIcons();

    /// Load map style
    rootBundle.loadString('assets/map_style.json').then((style) {
      _mapStyle = style;
    });

    /// Start location flow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationBloc>().add(RequestPermission());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) async {
          if (state.status == LocationStatus.tracking &&
              state.location != null &&
              _isFirstCameraMove) {
            final controller = await _mapCompleter.future;
            controller.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  state.location!.latitude,
                  state.location!.longitude,
                ),
              ),
            );
            _isFirstCameraMove = false;
          }
        },
        child: Stack(
          children: [
            _buildMap(),
            _buildDraggableSheet(),
          ],
        ),
      ),
    );
  }

  // ================= MAP =================

  Widget _buildMap() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        // 🟢 Tracking
        if (state.status == LocationStatus.tracking &&
            state.location != null) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                state.location!.latitude,
                state.location!.longitude,
              ),
              zoom: 15,
            ),
            onMapCreated: (controller) {
              if (!_mapCompleter.isCompleted) {
                _mapCompleter.complete(controller);
              }
              if (_mapStyle != null) {
                controller.setMapStyle(_mapStyle);
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          );
        }

        // 🚫 GPS OFF
        if (state.status == LocationStatus.serviceDisabled) {
          return _buildCenterMessage(
            "Please enable GPS from device settings",
          );
        }

        // 🔐 Permission denied
        if (state.status == LocationStatus.permissionDenied) {
          return _buildCenterMessage(
            "Location permission is required",
          );
        }

        // ❌ Error
        if (state.status == LocationStatus.error) {
          return _buildCenterMessage(
            state.errorMessage ?? "Unknown error",
            isError: true,
          );
        }

        // ⏳ Loading / Initial
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCenterMessage(String text, {bool isError = false}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: isError ? Colors.red : Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ================= DRAGGABLE SHEET =================

  Widget _buildDraggableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: nearbyPlacesMock.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildSheetHeader();
              }

              final place = nearbyPlacesMock[index - 1];
              return NearbyPlaceCard(
                name: place.name,
                category: place.category,
                description: place.description,
                servicesProvided: place.servicesProvided,
                address: place.address,
                imageUrls: place.imageUrls,
                rating: place.rating,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(AppDimens.paddingM),
          child: HeaderText("Nearby Places"),
        ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/place_category_entity.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_bloc.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_event.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_state.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/clinic/ui/clinic_main_widget.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/clinic/ui/clinic_skeleton_widget.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/gym/ui/gym_main_widget.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/store/ui/store_main_widget.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/store/ui/store_skeleton_widget.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/utils/build_screen_skeletonizer.dart';
import 'package:near_buy_gp/shared/util/screens_enum.dart';

import '../../../core/di/injection.dart';
import '../domain/entities/commonEntities/social_entity.dart';
import '../domain/entities/commonEntities/social_media_enum.dart';
import '../domain/entities/genericEntities/amenities_enum.dart';
import '../domain/entities/genericEntities/generic_entity.dart';
import '../domain/entities/genericEntities/opening_day_hour_entity.dart';
import 'generic/ui/generic_main_widget.dart';

final GenericEntity barberShopExample = GenericEntity(
  genericPlaceId: "barber_001",
  genericPlaceName: "Kings Barber Shop",
  genericPlaceType: "Barbershop",
  genericPlaceImages: [
    "https://images.unsplash.com/photo-1503951914875-452162b0f3f1",
    "https://images.unsplash.com/photo-1593702282069-90b2e2c1c6b7",
    "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9",
  ],
  rate: 4.7,
  reviewsCount: 342,
  genericPlaceDescription:
      "Kings Barber Shop offers premium grooming services including haircuts, beard styling, and hot towel shaves. Our professional barbers provide a modern experience in a classic atmosphere.",
  socialMediaLinks: [
    SocialData(
      socialMedia: SocialMedia.facebook,
      link: "https://www.facebook.com/kingsbarbershop",
    ),
    SocialData(
      socialMedia: SocialMedia.instagram,
      link: "https://www.instagram.com/kingsbarbershop",
    ),
    SocialData(
      socialMedia: SocialMedia.tiktok,
      link: "https://www.tiktok.com/@kingsbarbershop",
    ),
  ],
  address: "25 El Batal Ahmed Abdel Aziz St, Mohandessin, Giza, Egypt",
  lat: 30.047998,
  lng: 31.200742,
  phoneNumber: "+20 101 234 5678",
  placeStatus: true,
  // open
  amenityList: [
    Amenity.freeWifi,
    Amenity.airConditioned,
    Amenity.waitingArea,
    Amenity.acceptsCards,
    Amenity.parking,
    Amenity.onlineBooking,
  ],
  openingDayHourList: [
    OpeningDayHour(
      dayName: "Saturday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Sunday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Monday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Tuesday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Wednesday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Thursday",
      opensAt: "10:00 AM",
      closedAt: "12:00 AM",
    ),
    OpeningDayHour(
      dayName: "Friday",
      opensAt: "02:00 PM",
      closedAt: "12:00 AM",
    ),
  ],
);

class PlaceBaseScreen extends StatefulWidget {
  final String placeId;
  final ScreensType screensType;

  const PlaceBaseScreen({
    super.key,
    required this.placeId,
    required this.screensType,
  });

  @override
  State<PlaceBaseScreen> createState() => _PlaceBaseScreenState();
}

class _PlaceBaseScreenState extends State<PlaceBaseScreen> {
  late final PlaceBloc _bloc;

  @override
  void initState() {
    super.initState();

    /// Create bloc once
    _bloc = getIt<PlaceBloc>();

    /// Send first event once
    _bloc.add(EnterPlaceScreen(widget.placeId));
    if(kDebugMode){
      print("PRINT:PLACE SCREEN : ENTERED : ${widget.placeId}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          // Loading
          if (state.isLoading) {
            return Scaffold(
              backgroundColor: AppColors.white,
              extendBodyBehindAppBar: true,
              body: buildScreenSkeletonizerByType(widget.screensType),
            );
          }

          // Error
          if (state.error != null) {
            return Scaffold(
              backgroundColor: AppColors.white,
              body: Center(child: Text(state.error!)),
            );
          }

          // No data
          if (state.data == null) {
            return const Scaffold(
              body: Center(child: Text("No data available")),
            );
          }

          final placeData = state.data!;

          return Scaffold(
            backgroundColor: AppColors.white,
            extendBodyBehindAppBar: true,
            body: _buildScreenByType(placeData),
          );
        },
      ),
    );
  }

  Widget _buildScreenByType(PlaceCategoryEntity placeData) {
    switch (widget.screensType) {
      case ScreensType.store :
        return StoreMainWidget(storeEntity: placeData);

      case ScreensType.clinic:
        return ClinicMainWidget(clinicEntity: placeData);

      case ScreensType.generic:
        return GenericMainWidget(genericEntity: barberShopExample);

      case ScreensType.gym:
        return GymMainWidget();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/genericEntities/generic_entity.dart';

import '../../common/carosel_images_widget.dart';
import '../../common/contact_card.dart';
import '../../common/place_description_widget.dart';
import '../../common/place_services_header.dart';
import '../../store/components/location_card.dart';
import 'available_amenities_widget.dart';
import 'generic_opening_hours_widget.dart';

class GenericMainWidget extends StatelessWidget {
  final GenericEntity genericEntity;
  const GenericMainWidget({super.key, required this.genericEntity});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            child: CarouselSliderWidget(
              images: genericEntity.genericPlaceImages,
              height: 300,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20),
            child: PlaceDescriptionWidget(
              placeName: genericEntity.genericPlaceName,
              placeDescription: genericEntity.genericPlaceDescription,
              placeType: genericEntity.genericPlaceType,
              placeStatus: genericEntity.placeStatus,
              rate: genericEntity.rate,
              reviewsCount: genericEntity.reviewsCount,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ServicesHeader(headerText: "Hours"),
          ),
        ),
        SliverToBoxAdapter(
          child: GenericOpeningHours(
            openingHours: genericEntity.openingDayHourList,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ServicesHeader(headerText: "Amenities"),
          ),
        ),
        SliverToBoxAdapter(
          child: AvailableAmenitiesWidget(
            amenitiesList:  genericEntity.amenityList,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 14),
            child: ServicesHeader(headerText: "Location"),
          ),
        ),
        SliverToBoxAdapter(
          child: LocationMapCard(
            lat: genericEntity.lat,
            lng: genericEntity.lng,
            address: genericEntity.address,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 14),
            child: ServicesHeader(headerText: "Contact"),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 20),
          sliver: SliverList.builder(
            itemCount: genericEntity.socialMediaLinks.length,
            itemBuilder: (context, index) {
              return ContactCard(socialData: genericEntity.socialMediaLinks[index]);
            },
          ),
        ),








      ],
    );
  }
}

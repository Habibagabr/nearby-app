import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/clinicEntity/clinic_entity.dart';
import 'package:near_buy_gp/features/place_screen/presentation/clinic/components/service_widget.dart';
import 'package:near_buy_gp/features/place_screen/presentation/common/contact_card.dart';
import 'package:near_buy_gp/features/place_screen/presentation/store/components/location_card.dart';

import '../../common/carosel_images_widget.dart';
import '../../common/place_description_widget.dart';
import '../../common/place_services_header.dart';
import '../../store/ui/available_times_widget.dart';

class ClinicMainWidget extends StatelessWidget {
  final ClinicEntity clinicEntity;
  const ClinicMainWidget({super.key, required this.clinicEntity});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            child: CarouselSliderWidget(
              images: clinicEntity.clinicImages,
              height: 300,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20),
            child: PlaceDescriptionWidget(
              placeName: clinicEntity.clinicName,
              placeDescription: clinicEntity.clinicDescription,
              placeType: clinicEntity.clinicType,
              placeStatus: clinicEntity.placeStatus,
              rate: clinicEntity.rate,
              openingHours: clinicEntity.openingHours,
              reviewsCount: clinicEntity.reviewsCount,
              closingHours: clinicEntity.closingHours,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ServicesHeader(headerText: "Services"),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 20),
          sliver: SliverList.builder(
            itemCount: clinicEntity.clinicServices.length,
            itemBuilder: (context, index) {
              final service = clinicEntity.clinicServices[index];
              return ServiceWidget(clinicService: service);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ServicesHeader(
              headerText: "Available Today",
              icon: Icon(Icons.calendar_month),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AvailableTimesWidget(
            availableTimesList: clinicEntity.availableSlots,
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
            lat: clinicEntity.lat,
            lng: clinicEntity.lng,
            address: clinicEntity.address,
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
            itemCount: clinicEntity.socialMediaLinks.length,
            itemBuilder: (context, index) {
              return ContactCard(socialData: clinicEntity.socialMediaLinks[index]);
            },
          ),
        ),
      ],
    );
  }
}


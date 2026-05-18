import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/utils/get_todays_working_hour.dart';

import '../../../domain/entities/commonEntities/social_entity.dart';
import '../../../domain/entities/commonEntities/social_media_enum.dart';
import '../../../domain/entities/genericEntities/opening_day_hour_entity.dart';
import '../../../domain/entities/placeEntity/place_category_entity.dart';
import '../../common/carosel_images_widget.dart';
import '../../common/contact_card.dart';
import '../../common/opening_hours_schedule_widget.dart';
import '../../common/place_description_widget.dart';
import '../../common/place_services_header.dart';
import '../../common/places_bar.dart';
import '../../store/components/location_card.dart';
import '../components/service_widget.dart';

class ClinicMainWidget extends StatelessWidget {
  final PlaceCategoryEntity clinicEntity;

  ClinicMainWidget({super.key, required this.clinicEntity});

  @override
  Widget build(BuildContext context) {
    final socialItems = [
      SocialData(
        socialMedia: SocialMedia.phone,
        link: clinicEntity.place.phone ?? "No phone",
      ),
      if (clinicEntity.place.social?.facebook != null)
        SocialData(
          socialMedia: SocialMedia.facebook,
          link: clinicEntity.place.social!.facebook!,
        ),
      if (clinicEntity.place.social?.instagram != null)
        SocialData(
          socialMedia: SocialMedia.instagram,
          link: clinicEntity.place.social!.instagram!,
        ),
      if (clinicEntity.place.social?.tiktok != null)
        SocialData(
          socialMedia: SocialMedia.tiktok,
          link: clinicEntity.place.social!.tiktok!,
        ),
      if (clinicEntity.place.social?.twitter != null)
        SocialData(
          socialMedia: SocialMedia.twitter,
          link: clinicEntity.place.social!.twitter!,
        ),
      if (clinicEntity.place.social?.linkedin != null)
        SocialData(
          socialMedia: SocialMedia.linkedin,
          link: clinicEntity.place.social!.linkedin!,
        ),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              CarouselSliderWidget(
                images: clinicEntity.place.images,
                height: 300,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PlacesTopBar(
                  lat: clinicEntity.place.location.latitude,
                  lng: clinicEntity.place.location.longitude,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20),
            child: PlaceDescriptionWidget(
              placeName: clinicEntity.place.name,
              placeDescription: clinicEntity.place.description,
              placeType: clinicEntity.place.type,
              placeStatus: clinicEntity.place.status,
              rate: clinicEntity.place.rate,
              workingHours: getTodayWorkingHours(
                clinicEntity.place.workingHours,
              ),
              phoneNumber: clinicEntity.place.phone ?? "+02",
              lat: clinicEntity.place.location.latitude ?? 0.0,
              lng: clinicEntity.place.location.longitude ?? 0.0,
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
            itemCount: clinicEntity.place.itemsPaginated.items.length,
            itemBuilder: (context, index) {
              final service = clinicEntity.place.itemsPaginated.items[index];
              return ServiceWidget(clinicService: service);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ServicesHeader(
              headerText: "Working hours ",
              icon: Icon(Icons.calendar_month),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: OpeningHoursSchedule(
            openingHours: OpeningDayHour.fromWorkingHourToOpeningDayHour(
              clinicEntity.place.workingHours,
            ),
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
            lat: clinicEntity.place.location.latitude ?? 0.0,
            lng: clinicEntity.place.location.longitude ?? 0.0,
            address: clinicEntity.place.address,
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
            itemCount: socialItems.length,
            itemBuilder: (context, index) {
              return ContactCard(
                socialData: socialItems[index],
                onCardTapped: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

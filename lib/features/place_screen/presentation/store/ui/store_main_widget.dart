import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_bloc.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_state.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_event.dart';

import 'package:near_buy_gp/features/place_screen/domain/entities/commonEntities/social_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/commonEntities/social_media_enum.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/place_category_entity.dart';

import '../../common/carosel_images_widget.dart';
import '../../common/contact_card.dart';
import '../../common/place_description_widget.dart';
import '../../common/places_bar.dart';
import '../../utils/get_todays_working_hour.dart';
import '../../utils/open_socialMedia_link.dart';
import '../components/location_card.dart';
import '../components/product_widget.dart';
import '../components/products_categories_list_widget.dart';
import '../../common/opening_hours_schedule_widget.dart';
import '../../../domain/entities/genericEntities/opening_day_hour_entity.dart';
import 'store_skeleton_widget.dart';

class StoreMainWidget extends StatefulWidget {
  final PlaceCategoryEntity storeEntity;

  const StoreMainWidget({
    super.key,
    required this.storeEntity,
  });

  @override
  State<StoreMainWidget> createState() => _StoreMainWidgetState();
}

class _StoreMainWidgetState extends State<StoreMainWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final bloc = context.read<PlaceBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!state.isLoadingMore && !state.hasReachedEnd) {
        bloc.add(LoadNextPage());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        final items = state.items;

        final social = widget.storeEntity.place.social;

        final socialItems = [
          SocialData(
              socialMedia: SocialMedia.phone,
              link: widget.storeEntity.place.phone ?? "No phone"),
          if (social?.facebook != null)
            SocialData(
                socialMedia: SocialMedia.facebook,
                link: social!.facebook!),
          if (social?.instagram != null)
            SocialData(
                socialMedia: SocialMedia.instagram,
                link: social!.instagram!),
          if (social?.tiktok != null)
            SocialData(
                socialMedia: SocialMedia.tiktok,
                link: social!.tiktok!),
          if (social?.twitter != null)
            SocialData(
                socialMedia: SocialMedia.twitter,
                link: social!.twitter!),
          if (social?.linkedin != null)
            SocialData(
                socialMedia: SocialMedia.linkedin,
                link: social!.linkedin!),
        ];

        return CustomScrollView(
          controller: _scrollController,
          slivers: [

            /// 🔹 Images
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  CarouselSliderWidget(
                    images: widget.storeEntity.place.images,
                    height: 300,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: PlacesTopBar(
                      lat: widget.storeEntity.place.location.latitude,
                      lng: widget.storeEntity.place.location.longitude,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Description
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 20),
                child: PlaceDescriptionWidget(
                  placeName: widget.storeEntity.place.name,
                  placeDescription:
                  widget.storeEntity.place.description,
                  placeType: widget.storeEntity.place.type,
                  placeStatus: widget.storeEntity.place.status,
                  rate: widget.storeEntity.place.rate,
                  workingHours: getTodayWorkingHours(
                      widget.storeEntity.place.workingHours),
                  phoneNumber:
                  widget.storeEntity.place.phone ?? "+02",
                  lat: widget.storeEntity.place.location.latitude ?? 0.0,
                  lng: widget.storeEntity.place.location.longitude ?? 0.0,
                ),
              ),
            ),

            /// 🔹 Tabs
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 16),
                  child: Column(
                    children: [
                      TabBar(
                        tabs: const [
                          Tab(text: "Location"),
                          Tab(text: "Hours"),
                          Tab(text: "Contact"),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          children: [
                            LocationMapCard(
                              lat: widget.storeEntity.place.location.latitude ?? 0.0,
                              lng: widget.storeEntity.place.location.longitude ?? 0.0,
                              address: widget.storeEntity.place.address,
                            ),
                            OpeningHoursSchedule(
                              openingHours:
                              OpeningDayHour.fromWorkingHourToOpeningDayHour(
                                widget.storeEntity.place.workingHours,
                              ),
                            ),SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  socialItems.length,
                                      (index) => ContactCard(
                                    socialData: socialItems[index],
                                    onCardTapped: () =>
                                        openLink(socialItems[index].link),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 Categories
            SliverToBoxAdapter(
              child: ProductsCategoriesList(
                availableProductsCategories: widget.storeEntity.categories,
              ),
            ),
            /// 🔹 Products
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              sliver: SliverList.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                    product: items[index],
                    storeType:
                    widget.storeEntity.place.type,
                  );
                },
              ),
            ),

            /// 🔹 Loading More Skeleton
            if (state.isLoadingMore)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (_, __) => const ProductItemSkeleton(),
                  childCount: 2,
                ),
              ),
          ],
        );
      },
    );
  }
}
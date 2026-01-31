import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/presentation/store/ui/products_categories_list_widget.dart';

import '../../../domain/entities/storeEntity/store_entity.dart';
import '../../common/carosel_images_widget.dart';
import '../../common/contact_card.dart';
import '../../common/place_description_widget.dart';
import '../../common/place_services_header.dart';
import '../components/location_card.dart';
import '../components/product_widget.dart';


class StoreMainWidget extends StatelessWidget {
  final StoreEntity storeEntity;
  const StoreMainWidget({super.key, required this.storeEntity});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            child: CarouselSliderWidget(
              images: storeEntity.storeImages,
              height: 300,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20),
            child: PlaceDescriptionWidget(
              placeName: storeEntity.storeName,
              placeDescription: storeEntity.storeDescription,
              placeType: storeEntity.storeType,
              placeStatus: storeEntity.placeStatus,
              rate: storeEntity.rate,
              openingHours: storeEntity.openingHours,
              reviewsCount: storeEntity.reviewsCount,
              closingHours: storeEntity.closingHours,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ProductsCategoriesList(
            availableProductsCategories:
                storeEntity.availableProductsCategories,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 20),
          sliver: SliverList.builder(
            itemCount: storeEntity.storeProducts.length,
            itemBuilder: (context, index) {
              final product = storeEntity.storeProducts[index];
              return ProductItemWidget(storeProductEntity: product);
            },
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
            lat: storeEntity.lat,
            lng: storeEntity.lng,
            address: storeEntity.address,
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
            itemCount: storeEntity.socialMediaLinks.length,
            itemBuilder: (context, index) {
              return ContactCard(socialData: storeEntity.socialMediaLinks[index]);
            },
          ),
        ),

      ],
    );
  }
}

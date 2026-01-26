import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/presentation/storeWidgets/products_categories_list_widget.dart';

import '../../domain/entities/store_entity/store_entity.dart';
import '../commonWidgets/carosel_images_widget.dart';
import '../commonWidgets/place_description_widget.dart';
import 'components/product_widget.dart';

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
              storeName: storeEntity.storeName,
              storeDescription: storeEntity.storeDescription,
              storeType: storeEntity.storeType,
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
      ],
    );
  }
}

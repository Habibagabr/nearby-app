import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/storeEntity/store_product.dart';

import '../../common/carosel_images_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final StoreProductEntity storeProductEntity;

  const ProductItemWidget({
    super.key,
    required this.storeProductEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///  Product Images
          Align(
            alignment: Alignment.center,
            child:ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 90,
              height: 100,
              child: CarouselSliderWidget(
                images: storeProductEntity.productImages,
                height: 100,
              ),
            ),
          )
          ),

          const SizedBox(width: 14),

          ///  Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  storeProductEntity.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// Description
                Text(
                  storeProductEntity.productDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                /// Price + Category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${storeProductEntity.productPrice} ${storeProductEntity.productCurrency}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /// category
                    SizedBox(
                      width: 100,
                      child:Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100, // background color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child:Text(
                          storeProductEntity.productCategory,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray, // text color
                        ),
                      ),
                    ),
                    )
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

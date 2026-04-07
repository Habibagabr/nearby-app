import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/itemsEntity/restaurant_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/itemsEntity/super_market_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/product_entity.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/placeEntity/itemsEntity/clothing_entity.dart';
import '../../../domain/entities/placeEntity/itemsEntity/phramacy_entity.dart';
import '../../common/carosel_images_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;
  final String storeType;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.storeType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGray.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColors.lightGray.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 110,
              height: 220,
              child: CarouselSliderWidget(images: product.images, height: 220),
            ),
          ),

          const SizedBox(width: 14),

          /// 🔹 Content
          Expanded(
            child: SizedBox(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  /// 🔸 Name
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGray,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// 🔸 Description
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.darkGray.withOpacity(0.6),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// 🔸 Attributes
                  Expanded(child: _buildExtraSection()),

                  /// 🔸 Bottom Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 🟠 Price
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${product.price} EGP",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Dynamic Section
  Widget _buildExtraSection() {
    if (storeType == "food_beverage") {
      final restaurantProduct = product.attributes as RestaurantItemEntity;

      return Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          _infoChip(restaurantProduct.menuCategory),
          _infoChip(restaurantProduct.size),
        ],
      );
    } else if (storeType == "supermarket") {
      final superMarketProduct = product.attributes as SupermarketProductEntity;

      return Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          if (superMarketProduct.weight != null)
            _infoChip(superMarketProduct.weight!),
          if (superMarketProduct.stock != null)
            _infoChip("Stock: ${superMarketProduct.stock}"),
          if (superMarketProduct.brand != null)
            _infoChip(superMarketProduct.brand!),
        ],
      );
    } else if (storeType == "clothing") {
      final clothingProduct = product.attributes as ClothingProductEntity;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Sizes
          if (clothingProduct.size != null && clothingProduct.size!.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: clothingProduct.size!
                  .map((size) => _sizeChip(size))
                  .toList(),
            ),

          const SizedBox(height: 6),

          /// Colors
          if (clothingProduct.colorsAvailable != null &&
              clothingProduct.colorsAvailable!.isNotEmpty)
            Wrap(
              spacing: 6,
              children: clothingProduct.colorsAvailable!
                  .map((color) => _colorDot(color))
                  .toList(),
            ),

          const SizedBox(height: 6),

          /// Brand + Low Stock
          Wrap(
            spacing: 6,
            children: [
              if (clothingProduct.brand != null)
                _brandChip(clothingProduct.brand!),

              if (clothingProduct.stock != null && clothingProduct.stock! < 5)
                _lowStockChip(clothingProduct.stock!),
            ],
          ),
        ],
      );
    } else if (storeType == "pharmacy") {
      final pharmacyProduct = product.attributes as PharmacyProductEntity;

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          if (pharmacyProduct.brand != null) _brandChip(pharmacyProduct.brand!),

          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              /// 💊 Dosage
              if (pharmacyProduct.dosageForm != null)
                _infoChip(pharmacyProduct.dosageForm!),

              /// 🧴 Form (Tablet / Syrup)
              if (pharmacyProduct.packageSize != null)
                _infoChip(pharmacyProduct.packageSize!),

              /// ⚠ Low Stock
              if (pharmacyProduct.stock != null && pharmacyProduct.stock! < 5)
                _lowStockChip(pharmacyProduct.stock!),
            ],
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

/// 👕 Size Chip
Widget _sizeChip(String size) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      size.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// 🎨 Color Dot
Widget _colorDot(String colorName) {
  final color = _mapColor(colorName);

  return Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
      ],
    ),
  );
}

Color _mapColor(String color) {
  switch (color.toLowerCase()) {
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "navy":
      return const Color(0xFF1A237E);
    case "beige":
      return const Color(0xFFF5F5DC);
    case "brown":
      return Colors.brown;
    case "pink":
      return Colors.pink;
    case "yellow":
      return Colors.yellow;

    default:
      return Colors.grey;
  }
}

/// 🏷 Brand Chip
Widget _brandChip(String brand) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.black12),
    ),
    child: Text(
      brand,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  );
}

/// 🔴 Low Stock
Widget _lowStockChip(int stock) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(
      "Only $stock left",
      style: TextStyle(
        fontSize: 11,
        color: Colors.red.shade700,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// 🔹 Info Chip
Widget _infoChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.lightGray.withOpacity(0.4),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.darkGray,
      ),
    ),
  );
}

/// 🟠 Category Chip
Widget _buildCategoryChip(String category) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.orange.withOpacity(0.12),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      category,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.orange,
      ),
    ),
  );
}

Widget _prescriptionChip() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Text(
      "Prescription Required",
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Colors.red,
      ),
    ),
  );
}

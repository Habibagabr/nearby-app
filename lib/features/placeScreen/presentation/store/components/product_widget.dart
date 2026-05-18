import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/itemsEntity/restaurant_entity.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/itemsEntity/super_market_entity.dart';
import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/product_entity.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/placeEntity/itemsEntity/clothing_entity.dart';
import '../../../domain/entities/placeEntity/itemsEntity/phramacy_entity.dart';
import '../../common/carosel_images_widget.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Store-type → Entity mapping
//
// RestaurantItemEntity    : fast_food | cafe | dessert | seafood | food_beverage
// SupermarketProductEntity: supermarket | grocery
// ClothingProductEntity   : clothing | fashion
// PharmacyProductEntity   : pharmacy | medical | health
// SizedBox.shrink()       : everything else
// ─────────────────────────────────────────────────────────────────────────────
class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;
  final String storeType;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.storeType,
  });

  static const _restaurantTypes = {
    'fast_food',
    'cafe',
    'dessert',
    'seafood',
    'food_beverage',
  };
  static const _supermarketTypes = {'supermarket', 'grocery', "electronics"};

  static const _clothingTypes = {'clothing', 'fashion'};
  static const _pharmacyTypes = {'pharmacy', 'medical', 'health'};

  String get _group {
    if (_restaurantTypes.contains(storeType)) return 'restaurant';
    if (_supermarketTypes.contains(storeType)) return 'supermarket';
    if (_clothingTypes.contains(storeType)) return 'clothing';
    if (_pharmacyTypes.contains(storeType)) return 'pharmacy';
    return 'none';
  }

  @override
  Widget build(BuildContext context) {
    final group = _group;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child:Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Left: Carousel Image ───────────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: SizedBox(
              width: 140,
              child: CarouselSliderWidget(images: product.images),
            ),
          ),

          // ── Right: Content ─────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Status badge top-right ─────────────────────────────
                  _StatusBadge(group: group, product: product),

                  const SizedBox(height: 6),

                  // ── Name ───────────────────────────────────────────────
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A),
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ── Price ──────────────────────────────────────────────
                  Text(
                    "${product.price.toStringAsFixed(2)} EGP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.orange,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ── Description ────────────────────────────────────────
                  Text(
                    product.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Divider ────────────────────────────────────────────
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade200),

                  const SizedBox(height: 10),

                  // ── Dynamic attribute rows ─────────────────────────────
                  _ProductAttributes(product: product, group: group),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status Badge — top-right label (In Stock / Low Stock / Popular)
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String group;
  final ProductEntity product;

  const _StatusBadge({required this.group, required this.product});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = _resolve();

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
      ),
    );
  }

  (String, Color, Color) _resolve() {
    if (group == 'restaurant') {
      if (product.isAvailable) {
        return ("Available", const Color(0xFFE8F5E9), const Color(0xFF2E7D32));
      } else {
        return ("Not Available", Colors.red.shade50, Colors.red.shade600);
      }
    }

    // For inventory-bearing types, check stock
    int? stock;
    if (group == 'supermarket') {
      stock = (product.attributes as SupermarketProductEntity?)?.stock;
    } else if (group == 'clothing') {
      stock = (product.attributes as ClothingProductEntity?)?.stock;
    } else if (group == 'pharmacy') {
      stock = (product.attributes as PharmacyProductEntity?)?.stock;
    }

    if (stock != null && stock < 5) {
      return ('Low Stock', Colors.red.shade50, Colors.red.shade600);
    }
    return ('In Stock', const Color(0xFFE8F5E9), const Color(0xFF2E7D32));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dynamic Attributes — switches on group
// ─────────────────────────────────────────────────────────────────────────────

class _ProductAttributes extends StatelessWidget {
  final ProductEntity product;
  final String group;

  const _ProductAttributes({required this.product, required this.group});

  @override
  Widget build(BuildContext context) {
    return switch (group) {
      'restaurant' => _RestaurantRows(
        product.attributes as RestaurantItemEntity,
      ),
      'supermarket' => _SupermarketRows(
        product.attributes as SupermarketProductEntity,
      ),
      'clothing' => _ClothingRows(product.attributes as ClothingProductEntity),
      'pharmacy' => _PharmacyRows(product.attributes as PharmacyProductEntity),
      _ => const SizedBox.shrink(),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Per-type attribute rows
// ─────────────────────────────────────────────────────────────────────────────

// ── Restaurant ────────────────────────────────────────────────────────────────
class _RestaurantRows extends StatelessWidget {
  final RestaurantItemEntity data;

  const _RestaurantRows(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AttrRow(
          icon: Icons.menu_book_outlined,
          label: 'Category',
          value: data.menuCategory,
        ),
        _AttrRow(
          icon: Icons.straighten_rounded,
          label: 'Size',
          value: data.size,
        ),
      ],
    );
  }
}

// ── Supermarket ───────────────────────────────────────────────────────────────
class _SupermarketRows extends StatelessWidget {
  final SupermarketProductEntity data;

  const _SupermarketRows(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.brand != null)
          _AttrRow(
            icon: Icons.label_outline,
            label: 'Brand',
            value: data.brand!,
          ),
        if (data.weight != null)
          _AttrRow(
            icon: Icons.monitor_weight_outlined,
            label: 'Weight',
            value: data.weight!,
          ),
        if (data.stock != null)
          _AttrRow(
            icon: Icons.check_circle_outline,
            label: 'Stock',
            value: data.stock! < 5
                ? 'Low Stock (${data.stock})'
                : 'In Stock (${data.stock})',
            valueColor: data.stock! < 5 ? Colors.red : Colors.grey.shade700,
          ),
      ],
    );
  }
}

// ── Clothing ──────────────────────────────────────────────────────────────────
class _ClothingRows extends StatelessWidget {
  final ClothingProductEntity data;

  const _ClothingRows(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.brand != null)
          _AttrRow(
            icon: Icons.label_outline,
            label: 'Brand',
            value: data.brand!,
          ),

        // Sizes — value is chips instead of plain text
        if (data.size != null && data.size!.isNotEmpty)
          _AttrRowWidget(
            icon: Icons.checkroom_outlined,
            label: 'Sizes',
            child: Wrap(
              spacing: 4,
              children: data.size!.map((s) => _SizeChip(s)).toList(),
            ),
          ),

        // Colors — value is color dots
        if (data.colorsAvailable != null && data.colorsAvailable!.isNotEmpty)
          _AttrRowWidget(
            icon: Icons.palette_outlined,
            label: 'Colors',
            child: Wrap(
              spacing: 5,
              children: data.colorsAvailable!
                  .take(6)
                  .map((c) => _ColorDot(c))
                  .toList(),
            ),
          ),

        if (data.stock != null)
          _AttrRow(
            icon: Icons.check_circle_outline,
            label: 'Stock',
            value: data.stock! < 5
                ? 'Low Stock (${data.stock})'
                : 'In Stock (${data.stock})',
            valueColor: data.stock! < 5 ? Colors.red : Colors.grey.shade700,
          ),
      ],
    );
  }
}

// ── Pharmacy ──────────────────────────────────────────────────────────────────
class _PharmacyRows extends StatelessWidget {
  final PharmacyProductEntity data;

  const _PharmacyRows(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.brand != null)
          _AttrRow(
            icon: Icons.label_outline,
            label: 'Brand',
            value: data.brand!,
          ),
        if (data.activeIngredients != null &&
            data.activeIngredients!.isNotEmpty)
          _AttrRow(
            icon: Icons.science_outlined,
            label: 'Active Ingredients',
            value: data.activeIngredients!.join(', '),
          ),
        if (data.dosageForm != null)
          _AttrRow(
            icon: Icons.medication_outlined,
            label: 'Dosage Form',
            value: data.dosageForm!,
          ),
        if (data.packageSize != null)
          _AttrRow(
            icon: Icons.inventory_2_outlined,
            label: 'Package Size',
            value: data.packageSize!,
          ),
        if (data.stock != null)
          _AttrRow(
            icon: Icons.check_circle_outline,
            label: 'Stock',
            value: data.stock! < 5
                ? 'Low Stock (${data.stock})'
                : 'In Stock (${data.stock})',
            valueColor: data.stock! < 5 ? Colors.red : Colors.grey.shade700,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Attribute Row primitives
// ─────────────────────────────────────────────────────────────────────────────

/// Plain text value row — icon | bold label ......... value
class _AttrRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _AttrRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: Colors.grey.shade500),
          const SizedBox(width: 6),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: valueColor ?? Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget value row — icon | bold label ......... [child widget]
class _AttrRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _AttrRowWidget({
    required this.icon,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: Colors.grey.shade500),
          const SizedBox(width: 6),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: child),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small shared primitives (only used inside attribute rows)
// ─────────────────────────────────────────────────────────────────────────────

class _SizeChip extends StatelessWidget {
  final String size;

  const _SizeChip(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        size.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final String colorName;

  const _ColorDot(this.colorName);

  @override
  Widget build(BuildContext context) {
    final resolved = _mapColor(colorName);
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: resolved,
        shape: BoxShape.circle,
        border: Border.all(
          color: resolved == Colors.white
              ? Colors.grey.shade400
              : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: resolved.withOpacity(0.35),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }

  Color _mapColor(String color) {
    return switch (color.toLowerCase()) {
      'black' => Colors.black,
      'white' => Colors.white,
      'red' => Colors.red,
      'blue' => Colors.blue,
      'navy' => const Color(0xFF1A237E),
      'beige' => const Color(0xFFF5F5DC),
      'brown' => Colors.brown,
      'pink' => Colors.pink,
      'yellow' => Colors.yellow,
      'green' => Colors.green,
      'grey' || 'gray' => Colors.grey,
      'purple' => Colors.purple,
      'orange' => Colors.orange,
      _ => Colors.grey.shade400,
    };
  }
}

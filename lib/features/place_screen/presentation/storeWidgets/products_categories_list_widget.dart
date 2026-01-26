import 'package:flutter/material.dart';

class ProductsCategoriesList extends StatefulWidget {

  const ProductsCategoriesList({super.key, required this.availableProductsCategories});

  @override
  State<ProductsCategoriesList> createState() =>
      _ProductsCategoriesListState();
}

class _ProductsCategoriesListState extends State<ProductsCategoriesList> {
  final List<String> availableProductsCategories;
  _ProductsCategoriesListState({required this.availableProductsCategories});
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: av.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ProductsComponent(
            productCategory: categories[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

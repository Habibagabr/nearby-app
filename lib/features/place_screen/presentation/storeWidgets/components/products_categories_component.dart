import 'package:flutter/material.dart';

class ProductsComponent extends StatelessWidget {
  final String productCategory;
  final bool isSelected;
  final VoidCallback? onTap;

  const ProductsComponent({
    super.key,
    required this.productCategory,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Text(
          productCategory,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

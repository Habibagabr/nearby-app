class StoreProductEntity {
  final List<String> productImages;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productCurrency;
  final String productCategory;

  StoreProductEntity({
    required this.productImages,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productCurrency,
    required this.productCategory,
  });
}

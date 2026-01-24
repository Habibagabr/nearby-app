class CategoryIconResolver {
  static const Set<String> _supported = {
    'clothing', 'cafe', 'pharmacy', 'gym', 'restaurant'
  };

  static String resolve(String category) {
    final baseUrl = "assets/images/markers/";
    final cleanCategory = category.toLowerCase().trim();

    // If it's in our list, use it; otherwise, use default
    final fileName = _supported.contains(cleanCategory)
        ? cleanCategory
        : 'default';

    return '$baseUrl$fileName.png';
  }
}

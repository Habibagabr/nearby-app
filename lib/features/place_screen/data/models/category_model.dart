class CategoryModel {
  final String? id;
  final String? name;

  const CategoryModel({
    this.id,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }
}

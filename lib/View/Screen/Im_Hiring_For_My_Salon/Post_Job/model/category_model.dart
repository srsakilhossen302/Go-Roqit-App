class CategoryModel {
  final String id;
  final String name;
  final String description;
  final bool status;

  CategoryModel({
    required this.id,
    required this.name,
    this.description = '',
    this.status = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? true,
    );
  }
}

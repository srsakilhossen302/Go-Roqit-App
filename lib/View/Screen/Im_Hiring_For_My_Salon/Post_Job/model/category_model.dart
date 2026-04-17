class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool status;

  CategoryModel({
    required this.id,
    required this.name,
    this.description = '',
    this.image = '',
    this.status = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String img = '';
    if (json['image'] != null) {
      img = json['image'].toString().startsWith('http') 
          ? json['image'] 
          : "https://fahim5001.naimulhassan.me/${json['image']}";
    }

    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: img,
      status: json['status'] ?? true,
    );
  }
}

class Category {
  int id;
  String name;
  String? imagePath;
  int? count;

  Category({required this.id, required this.name, this.imagePath, this.count});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        imagePath: json['image_path'],
        count: json['count']);
  }
}

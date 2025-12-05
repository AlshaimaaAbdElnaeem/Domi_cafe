class ProductModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String rating;
  final String category;
  final String prepTime;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
    required this.prepTime,
  });

  // استخدمي doc.id مباشرة
  ProductModel.fromJson(Map<String, dynamic> json, String docId)
      : id = docId,
        name = json['name'] ?? '',
        description = json['description'] ?? '',
        price = json['price'] ?? '',
        image = json['image'] ?? '',
        rating = json['rating'] ?? '',
        category = json['category'] ?? '',
        prepTime = json['prepTime'] ?? '';
}

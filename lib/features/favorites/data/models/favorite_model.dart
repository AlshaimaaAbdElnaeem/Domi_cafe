// lib/features/favorites/data/models/favorite_model.dart
class FavoriteModel {
  final String id;
  final String productId;

  FavoriteModel({required this.id, required this.productId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
      };

  factory FavoriteModel.fromJson(Map<String, dynamic> json, String id) {
    return FavoriteModel(
      id: id,
      productId: json['productId'] ?? id,
    );
  }
}

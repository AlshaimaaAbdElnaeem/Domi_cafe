// lib/features/favorites/domain/entities/favorite_entity.dart
class FavoriteEntity {
  final String id;
  final String productId;
  final DateTime createdAt;

  FavoriteEntity({
    required this.id,
    required this.productId,
    required this.createdAt,
  });
}

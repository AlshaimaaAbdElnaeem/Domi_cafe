// lib/features/favorites/domain/repositories/favorite_repository.dart
import '../entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(String userId, FavoriteEntity entity);
  Future<void> removeFavorite(String userId, String productId);
  Stream<List<FavoriteEntity>> getFavorites(String userId);
}

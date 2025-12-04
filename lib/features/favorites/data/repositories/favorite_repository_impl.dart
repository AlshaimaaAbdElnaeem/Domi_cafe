// lib/features/favorites/data/repositories/favorite_repository_impl.dart
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_ds.dart';
import '../models/favorite_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDs remote;

  FavoriteRepositoryImpl(this.remote);

  @override
  Future<void> addFavorite(String userId, FavoriteEntity entity) async {
    await remote.addFavorite(
      userId,
      FavoriteModel(
        id: entity.id,
        productId: entity.productId,
      ),
    );
  }

  @override
  Future<void> removeFavorite(String userId, String productId) async {
    await remote.removeFavorite(userId, productId);
  }

  @override
  Stream<List<FavoriteEntity>> getFavorites(String userId) {
    return remote.getFavorites(userId);
  }
}

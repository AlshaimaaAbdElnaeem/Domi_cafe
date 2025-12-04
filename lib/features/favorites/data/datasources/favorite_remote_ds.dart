// lib/features/favorites/data/datasources/favorite_remote_ds.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/favorite_entity.dart';
import '../models/favorite_model.dart';

class FavoriteRemoteDs {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addFavorite(String userId, FavoriteModel model) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(model.id)
        .set(model.toJson()..addAll({'createdAt': FieldValue.serverTimestamp()}));
  }

  Future<void> removeFavorite(String userId, String productId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId)
        .delete();
  }

  Stream<List<FavoriteEntity>> getFavorites(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map(
      (snapshot) => snapshot.docs.map(
        (doc) {
          final data = doc.data();
          return FavoriteEntity(
            id: doc.id,
            productId: data['productId'] ?? doc.id,
            createdAt: data['createdAt'] != null
                ? (data['createdAt'] as Timestamp).toDate()
                : DateTime.now(),
          );
        },
      ).toList(),
    );
  }
}

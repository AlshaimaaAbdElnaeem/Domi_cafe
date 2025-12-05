import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domi_cafe/features/cart/domain/entities/cart_item_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToCart(String userId, product) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(product.id)
        .set({
      "id": product.id,
      "name": product.name,
      "image": product.image,
      "price": product.price,
      "quantity": 1,
    }, SetOptions(merge: true));
  }

  @override
  Future<List<CartItem>> getCart(String userId) async {
    final snapshot = await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .get();

    return snapshot.docs
        .map((doc) => CartItem.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId)
        .delete();
  }
}

abstract class CartRepository {
  Future<List<CartItem>> getCart(String userId);
  Future<void> addToCart(String userId, CartItem item);
  Future<void> removeFromCart(String userId, String productId);
}


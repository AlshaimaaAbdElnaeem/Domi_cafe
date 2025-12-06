import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domi_cafe/features/cart/domain/entities/cart_item_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToCart(String userId, CartItem item) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(item.id)
        .set(item.toJson(), SetOptions(merge: true));
  }

  @override
  Future<List<CartItem>> getCart(String userId) async {
    try {
      final snapshot = await firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .get();

      print('Total documents: ${snapshot.docs.length}');

      final List<CartItem> items = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data != null) {
          print('Cart document data: $data');
          print('Data type: ${data.runtimeType}');

          final cartItem = CartItem.fromJson(data);
          print('✓ Successfully created CartItem: ${cartItem.id}');
          items.add(cartItem);
        }
      }

      print('Total items parsed: ${items.length}');
      return items;
    } catch (e, stackTrace) {
      print('❌ Error in getCart: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
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


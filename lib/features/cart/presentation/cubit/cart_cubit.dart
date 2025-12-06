import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUsecase addToCartUsecase;
  final GetCartUsecase getCartUsecase;
  final RemoveFromCartUsecase removeFromCartUsecase;
  String userId;

  CartCubit({
    required this.addToCartUsecase,
    required this.getCartUsecase,
    required this.removeFromCartUsecase,
    required this.userId,
  }) : super(const CartState.initial()) {
    if (userId.isNotEmpty) {
      loadCart(); // <-- هنا الكارت يتحمل تلقائي عند إنشاء الـ Cubit
    }
  }

  // Method to update userId when user logs in
  void updateUserId(String newUserId) {
    userId = newUserId;
    if (userId.isNotEmpty) {
      loadCart();
    }
  }

  Future<void> loadCart() async {
    try {
      print('🔄 loadCart called for userId: $userId');
      emit(const CartState.loading());
      print('✓ Emitted CartLoading');

      final items = await getCartUsecase(userId);
      print('✓ Got ${items.length} items from usecase');
      print('Items: ${items.map((e) => e.id).toList()}');

      print('About to emit CartLoaded...');
      emit(CartState.loaded(items));
      print('✓ Successfully emitted CartLoaded with ${items.length} items');
    } catch (e, stackTrace) {
      print('❌ Error in loadCart: $e');
      print('Stack trace: $stackTrace');
      emit(CartState.error(e.toString()));
    }
  }

  Future<void> addToCart(CartItem product) async {
    await addToCartUsecase(userId, product);
    loadCart();
  }

  Future<void> removeFromCart(String productId) async {
    await removeFromCartUsecase(userId, productId);
    loadCart();
  }

  Future<void> increaseQty(String productId) async {
    final stateData = state;
    if (stateData is CartLoaded) {
      // Find the item to update
      final item = stateData.items.firstWhere((item) => item.id == productId);

      // Create updated item with increased quantity
      final updatedItem = CartItem(
        id: item.id,
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity + 1,
      );

      // Save to Firestore
      await addToCartUsecase(userId, updatedItem);

      // Reload cart from Firestore to ensure consistency
      await loadCart();
    }
  }

  Future<void> decreaseQty(String productId) async {
    final stateData = state;
    if (stateData is CartLoaded) {
      // Find the item to update
      final item = stateData.items.firstWhere((item) => item.id == productId);

      if (item.quantity > 1) {
        // Create updated item with decreased quantity
        final updatedItem = CartItem(
          id: item.id,
          name: item.name,
          image: item.image,
          price: item.price,
          quantity: item.quantity - 1,
        );

        // Save to Firestore
        await addToCartUsecase(userId, updatedItem);

        // Reload cart from Firestore to ensure consistency
        await loadCart();
      }
    }
  }
}

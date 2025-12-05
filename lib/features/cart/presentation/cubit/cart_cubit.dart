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
  final String userId;

  CartCubit({
    required this.addToCartUsecase,
    required this.getCartUsecase,
    required this.removeFromCartUsecase,
    required this.userId,
  }) : super(CartInitial()) {
    loadCart(); // <-- هنا الكارت يتحمل تلقائي عند إنشاء الـ Cubit
  }

  Future<void> loadCart() async {
    try {
      emit(CartLoading());
      final items = await getCartUsecase(userId);
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
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
      final updatedItems = stateData.items.map((item) {
        if (item.id == productId) {
          return CartItem(
            id: item.id,
            name: item.name,
            image: item.image,
            price: item.price,
            quantity: item.quantity + 1,
          );
        }
        return item;
      }).toList();
      emit(CartLoaded(updatedItems));
    }
  }

  Future<void> decreaseQty(String productId) async {
    final stateData = state;
    if (stateData is CartLoaded) {
      final updatedItems = stateData.items.map((item) {
        if (item.id == productId && item.quantity > 1) {
          return CartItem(
            id: item.id,
            name: item.name,
            image: item.image,
            price: item.price,
            quantity: item.quantity - 1,
          );
        }
        return item;
      }).toList();
      emit(CartLoaded(updatedItems));
    }
  }
}

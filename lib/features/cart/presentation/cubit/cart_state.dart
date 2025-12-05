import 'package:domi_cafe/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class CartLoaded extends CartState {
  final List<CartItem> items;
  CartLoaded(this.items);
}
class CartError extends CartState {
  final String message;
  CartError(this.message);
}

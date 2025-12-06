import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item_entity.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = CartInitial;
  const factory CartState.loading() = CartLoading;
  const factory CartState.loaded(List<CartItem> items) = CartLoaded;
  const factory CartState.error(String message) = CartError;
}

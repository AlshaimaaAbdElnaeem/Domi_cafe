import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_entity.freezed.dart';
part 'cart_item_entity.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String name,
    required String image,
    required double price,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

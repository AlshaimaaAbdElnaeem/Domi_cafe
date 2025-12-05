import '../repositories/cart_repository.dart';
import '../../domain/entities/cart_item_entity.dart';

class AddToCartUsecase {
  final CartRepository repo;
  AddToCartUsecase(this.repo);

  Future<void> call(String userId, CartItem item) {
    return repo.addToCart(userId, item);
  }
}

import '../repositories/cart_repository.dart';

class RemoveFromCartUsecase {
  final CartRepository repo;
  RemoveFromCartUsecase(this.repo);

  Future<void> call(String userId, String productId) {
    return repo.removeFromCart(userId, productId);
  }
}

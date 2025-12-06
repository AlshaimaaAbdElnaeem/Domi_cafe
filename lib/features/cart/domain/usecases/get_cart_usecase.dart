import '../repositories/cart_repository.dart';
import '../../domain/entities/cart_item_entity.dart';

class GetCartUsecase {
  final CartRepository repo;
  GetCartUsecase(this.repo);

  Future<List<CartItem>> call(String userId) async {
    return await repo.getCart(userId);
  }
}

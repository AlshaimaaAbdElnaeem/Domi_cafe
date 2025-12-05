import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../repo/product_repo.dart';
import '../../../../core/utils/failure.dart';

class GetProductUseCase {
  final ProductRepo repo;

  GetProductUseCase(this.repo);

  Future<Either<ProductEntity, Failure>> call(String id) async {
    return await repo.getProduct(id);
  }
}

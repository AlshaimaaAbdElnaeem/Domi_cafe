import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../../../../core/utils/failure.dart';

abstract class ProductRepo {
  Future<Either<ProductEntity, Failure>> getProduct(String id);
}

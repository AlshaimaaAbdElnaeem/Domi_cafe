import 'package:dartz/dartz.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repo/product_repo.dart';
import '../../../../../core/utils/failure.dart';
import '../datasources/product_remote_ds.dart';
import 'package:domi_cafe/features/product_details/data/models/product_model.dart';


class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDS remoteDS;

  ProductRepoImpl(this.remoteDS);

  @override
  Future<Either<ProductEntity, Failure>> getProduct(String id) async {
    try {
      final ProductModel? productModel = await remoteDS.getProduct(id);

      if (productModel != null) {
        // تحويل ProductModel إلى ProductEntity
        final productEntity = ProductEntity(
          id: productModel.id,
          name: productModel.name,
          description: productModel.description,
          price: productModel.price,
          image: productModel.image,
          rating: productModel.rating,
          category: productModel.category,
          prepTime: productModel.prepTime,
        );
        return Left(productEntity);
      }

      return Right(Failure("Product not found"));
    } catch (e) {
      return Right(Failure(e.toString()));
    }
  }
}

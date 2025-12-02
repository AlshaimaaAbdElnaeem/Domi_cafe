import 'package:dartz/dartz.dart';
import 'package:domi_cafe/core/networking/firebase_config.dart';
import 'package:domi_cafe/core/utils/failure.dart';
import 'package:domi_cafe/features/home/data/models/product_model.dart';

class RemoteDatasource {
FirestoreService firestoreService = FirestoreService();


  Future<Either<List<ProductModel>,Failure>> getData() async{

    try {
      final result = await firestoreService.getCollection(collection: 'products');

      List<ProductModel> products =
          result.map((e) => ProductModel.fromJson(e)).toList();
          
     return Left(products); 

    } catch (e) {
      return Right(Failure(e.toString()));
    }

  }
}
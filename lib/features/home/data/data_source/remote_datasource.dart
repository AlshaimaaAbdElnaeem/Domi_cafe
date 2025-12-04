// lib/features/home/data/data_source/remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:domi_cafe/core/utils/failure.dart';
import '../../../product_details/data/models/product_model.dart';

class RemoteDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Either<Failure, List<ProductModel>>> getData() async {
    try {
      final snapshot = await firestore.collection('products').get();

      final products = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();

      return Right(products); // Right = Success
    } catch (e) {
      return Left(Failure(e.toString())); // Left = Failure
    }
  }
}

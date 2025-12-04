// lib/features/product_details/data/datasources/product_remote_ds.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domi_cafe/features/product_details/data/models/product_model.dart';


class ProductRemoteDS {  // ← لازم يكون الكلاس بنفس الاسم هنا
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ProductModel?> getProduct(String id) async {
    final doc = await firestore.collection("products").doc(id).get();
    

    if (doc.exists) {
      return ProductModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }
}

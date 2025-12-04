import 'package:domi_cafe/features/product_details/data/models/product_model.dart';




abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final List<ProductModel> products;
  LoadedProductState(this.products);
}

class ErrorProductState extends ProductState {
  final String error;
  ErrorProductState(this.error);
}

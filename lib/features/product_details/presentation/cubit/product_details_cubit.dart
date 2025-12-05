import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/entities/product_entity.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductUseCase getProductUseCase;

  ProductDetailsCubit(this.getProductUseCase) : super(ProductDetailsInitial());

  Future<void> getProduct(String id) async {
    emit(ProductDetailsLoading());
    final result = await getProductUseCase(id);

    result.fold(
      (product) => emit(ProductDetailsLoaded(product)),
      (error) => emit(ProductDetailsError(error.message)),
    );
  }
}

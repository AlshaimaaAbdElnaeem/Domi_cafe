// lib/features/home/presentation/cubit/product_cubit/product_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_source/remote_datasource.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final RemoteDatasource remoteDatasource;

  ProductCubit(this.remoteDatasource) : super(InitialProductState());

  Future<void> getData() async {
    emit(LoadingProductState());

    final result = await remoteDatasource.getData();

    result.fold(
      (failure) => emit(ErrorProductState(failure.message)),
      (products) => emit(LoadedProductState(products)),
    );
  }
}

import 'package:domi_cafe/features/home/data/data_source/remote_datasource.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit():super(InitialProductState());
  RemoteDatasource remoteDatasource = RemoteDatasource();

  Future<void> getData()async{
    emit(LoadingProductState());
    final result = await remoteDatasource.getData();
    result.fold((l) => emit(LoadedProductState(l)), (r) => emit(ErrorProductState(r.message)));
  }

}
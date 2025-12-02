import 'package:domi_cafe/features/card/presentation/widgets/card_widget.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
   var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ProductCubit()..getData(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title:  Text('Menu' ,
            
            style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
            if (state is LoadingProductState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedProductState) {
             return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: state.products.length,
                     itemBuilder:(context, index){
                      return CardWidget(
                        productModel: state.products[index],
                        onDetailsTap: (){
                          // Navigate to details screen
                        },
                        onFavoriteTap: (){
                          // Handle favorite tap
                        },
                        onCartTap: (){
                          // Handle cart tap
                        },
                      );
                     } );
            } else if (state is ErrorProductState) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
            },
          )
        ),
    );
  }
}
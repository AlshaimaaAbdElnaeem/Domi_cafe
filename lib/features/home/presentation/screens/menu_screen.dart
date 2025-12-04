import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domi_cafe/features/card/presentation/widgets/card_widget.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_state.dart';
import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:domi_cafe/features/home/data/data_source/remote_datasource.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key}); // نخليها const

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // بدل ما نعمل BlocProvider جوه الـ build مباشرة، نستخدم builder
    return BlocProvider(
      create: (_) => ProductCubit(RemoteDatasource())..getData(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title: Text(
              'Menu',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
                if (state.products.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return CardWidget(
                      productModel: product,
                      onDetailsTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.productDetails,
                          arguments: product.id,
                        );
                      },
                      onFavoriteTap: () {},
                      onCartTap: () {},
                    );
                  },
                );
              } else if (state is ErrorProductState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}

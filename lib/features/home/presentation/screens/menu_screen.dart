import 'package:domi_cafe/features/cart/domain/entities/cart_item_entity.dart';
import 'package:domi_cafe/features/cart/domain/repositories/cart_repository.dart';
import 'package:domi_cafe/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:domi_cafe/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:domi_cafe/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:domi_cafe/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:domi_cafe/features/favorites/data/datasources/favorite_remote_ds.dart';
import 'package:domi_cafe/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:domi_cafe/features/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domi_cafe/features/card/presentation/widgets/card_widget.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:domi_cafe/features/home/presentation/cubit/product_cubit/product_state.dart';
import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:domi_cafe/features/home/data/data_source/remote_datasource.dart';
import 'package:domi_cafe/features/cart/data/repositories/cart_repository_impl.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductCubit(RemoteDatasource())..getData(),
        ),
        BlocProvider(
          create: (_) => CartCubit(
            addToCartUsecase: AddToCartUsecase(CartRepositoryImpl()),
            getCartUsecase: GetCartUsecase(CartRepositoryImpl()),
            removeFromCartUsecase: RemoveFromCartUsecase(CartRepositoryImpl()),
            userId: '',
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text(
            'Menu',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, size: 28),
              onPressed: () {
                Navigator.pushNamed(context, Routes.cart);
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is LoadingProductState) {
              return const Center(child: CircularProgressIndicator());
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
  return BlocProvider(
    create: (_) => FavoriteCubit(FavoriteRepositoryImpl(FavoriteRemoteDs())),
    child: CardWidget(
      productModel: product,
      onDetailsTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product.id,
        );
      },
                onFavoriteTap: () {},
onCartTap: () {
  print("PRODUCT DATA:");
  print("ID: ${product.id}");
  print("NAME: ${product.name}");
  print("PRICE: ${product.price}");
  print("IMAGE: ${product.image}");
  print("------");

  final cartItem = CartItem(
    id: product.id,
    name: product.name,
    image: product.image,
    price: double.tryParse(product.price.toString()) ?? 0.0,
    quantity: 1,
  );

  context.read<CartCubit>().addToCart(cartItem);
},


    ),
  );
},

              );
            } else if (state is ErrorProductState) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

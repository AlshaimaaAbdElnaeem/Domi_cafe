import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_details_cubit.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../data/repo/product_repo_impl.dart';
import '../../data/datasources/product_remote_ds.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(
        GetProductUseCase(
          ProductRepoImpl(ProductRemoteDS()),
        ),
      )..getProduct(productId),
      child: Scaffold(
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailsError) {
              return Center(child: Text(state.msg));
            }

            if (state is ProductDetailsLoaded) {
              final p = state.product;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, size: 30),
                        ),
                      ),

                      // Image
                      CircleAvatar(
                        radius: 90,
                        backgroundImage: CachedNetworkImageProvider(p.image),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        p.name,
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${p.price} EGP",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time, size: 20),
                          const SizedBox(width: 5),
                          Text(p.prepTime),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        p.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),

                      const Spacer(),

                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.brown,
                          ),
                          onPressed: () {
                            final cartItem = CartItem(
                              id: p.id,
                              name: p.name,
                              image: p.image,
                              price: double.tryParse(p.price) ?? 0.0,
                              quantity: 1,
                            );

                            context.read<CartCubit>().addToCart(cartItem);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${p.name} added to cart'),
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:domi_cafe/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightPrimary,
        title: const Text("My Cart", style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                  child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18, color: AppColors.lightText),
              ));
            }

            final subtotal = state.items.fold<double>(
                0, (sum, item) => sum + item.price * item.quantity);
            final service = subtotal * 0.1;
            final total = subtotal + service;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (_, i) {
                      final item = state.items[i];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              child: Image.network(
                                item.image,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.lightHeading),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "\$${item.price}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => context
                                      .read<CartCubit>()
                                      .decreaseQty(item.id),
                                  icon: const Icon(Icons.remove_circle),
                                  color: AppColors.lightPrimary,
                                ),
                                Text(item.quantity.toString()),
                                IconButton(
                                  onPressed: () => context
                                      .read<CartCubit>()
                                      .increaseQty(item.id),
                                  icon: const Icon(Icons.add_circle),
                                  color: AppColors.lightPrimary,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => context
                                      .read<CartCubit>()
                                      .removeFromCart(item.id),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: AppColors.lightPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal",
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.white)),
                          Text("\$${subtotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18, color: AppColors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Service (10%)",
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.white)),
                          Text("\$${service.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18, color: AppColors.white)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white)),
                          Text("\$${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

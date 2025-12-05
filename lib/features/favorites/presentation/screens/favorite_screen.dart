// lib/features/favorites/presentation/screens/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product_details/data/datasources/product_remote_ds.dart';
import '../../../product_details/data/models/product_model.dart';
import '../../domain/entities/favorite_entity.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';
import 'package:domi_cafe/features/card/presentation/widgets/card_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDs = ProductRemoteDS();

    return BlocProvider.value(
      value: BlocProvider.of<FavoriteCubit>(context)..loadFavorites(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(child: Text('No favorites yet'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final fav = favorites[index] as FavoriteEntity;

                return FutureBuilder<ProductModel?>(
                  future: productDs.getProduct(fav.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // إذا المنتج null أو غير موجود في Firestore
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const SizedBox.shrink();
                    }

                    final product = snapshot.data!;

                    // حماية إضافية: أي حقل ناقص أو empty
                    if (product.id.isEmpty || product.name.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return CardWidget(
                      productModel: product,
                      onFavoriteTap: () => context.read<FavoriteCubit>().toggleFavorite(fav),
                      onCartTap: () {
                        // هنا ممكن تضيف إضافة للكارت
                      },
                      onDetailsTap: () {
                        // ممكن تضيف نافيجيت للتفاصيل لو حبيت
                      },
                    );
                  },
                );
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.error));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/presentation/cubit/favorite_cubit.dart';
import '../../../favorites/presentation/cubit/favorite_state.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import 'package:domi_cafe/features/product_details/data/models/product_model.dart';


class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.productModel,
    this.onCartTap,
    this.onDetailsTap,
    this.onFavoriteTap,
  }) : super(key: key);

  final ProductModel productModel;
  final void Function()? onCartTap;
  final void Function()? onDetailsTap;
  final void Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onDetailsTap,
      child: SizedBox(
        width: 180.w,
        height: 250.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: productModel.image.isNotEmpty
                      ? productModel.image
                      : 'https://via.placeholder.com/150',
                  progressIndicatorBuilder: (context, url, progress) =>
                      Center(child: CircularProgressIndicator(value: progress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, state) {
                              bool isFav = false;
                              if (state is FavoriteLoaded) {
                                isFav = state.favorites.any((fav) => fav.productId == productModel.id);
                              }
                              return IconButton(
                                onPressed: () {
                                  final favoriteEntity = FavoriteEntity(
                                    id: productModel.id,
                                    productId: productModel.id,
                                    createdAt: DateTime.now(),
                                  );
                                  context.read<FavoriteCubit>().toggleFavorite(favoriteEntity);
                                  if (onFavoriteTap != null) onFavoriteTap!();
                                },
                                icon: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  size: 24.sp,
                                  color: isFav ? Colors.red : theme.iconTheme.color,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: onCartTap,
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              size: 24.sp,
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        productModel.name.isNotEmpty ? productModel.name : 'Unnamed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${productModel.price.isNotEmpty ? productModel.price : '0'}\$',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: theme.primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14.sp),
                              SizedBox(width: 4.w),
                              Text(
                                productModel.rating.isNotEmpty ? productModel.rating : '0',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

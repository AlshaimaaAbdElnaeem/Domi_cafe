import 'package:cached_network_image/cached_network_image.dart';
import 'package:domi_cafe/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.productModel,
    this.onFavoriteTap,
    this.onCartTap,
    this.onDetailsTap,
  });

  final ProductModel productModel;
  final void Function()? onFavoriteTap, onCartTap, onDetailsTap;

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
              // -------------------- Image --------------------
              Positioned.fill(
                child: CachedNetworkImage(
       fit: BoxFit.cover,
       imageUrl: productModel.image,
       progressIndicatorBuilder: (context, url, downloadProgress) => 
               CircularProgressIndicator(value: downloadProgress.progress),
       errorWidget: (context, url, error) => Icon(Icons.error),
    ),
              ),

              // -------------------- Overlay --------------------
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.7), // Frosted-like effect
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // ---------- Icons Row ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: onFavoriteTap,
                            icon: Icon(
                              Icons.favorite_border,
                              size: 24.sp,
                              color: theme.iconTheme.color,
                            ),
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

                      // ---------- Product Name ----------
                      Text(
                        productModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),

                      // ---------- Price & Rating ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${productModel.price}\$',
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
                                productModel.rating,
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

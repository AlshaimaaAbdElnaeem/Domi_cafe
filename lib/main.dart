import 'package:domi_cafe/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'features/cart/domain/usecases/get_cart_usecase.dart';
import 'features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'features/home/data/data_source/remote_datasource.dart';
import 'firebase_options.dart'; // مهم جداً

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⭐ تهيئة Firebase بالطريقة الصحيحة
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(
            addToCartUsecase: AddToCartUsecase(CartRepositoryImpl()),
            getCartUsecase: GetCartUsecase(CartRepositoryImpl()),
            removeFromCartUsecase: RemoveFromCartUsecase(CartRepositoryImpl()),
            userId: '',
          ),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(RemoteDatasource())..getData(),
        ),
        // لو في Cubits عالمية تانية ممكن تضيفها هنا
      ],
      child: const MyApp(),
    ),
  );
}

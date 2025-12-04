import 'package:domi_cafe/features/home/presentation/screens/home_screen.dart';
import 'package:domi_cafe/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:domi_cafe/features/layout/presentation/screens/home_layout.dart';
import 'package:domi_cafe/features/splash/presentation/screens/splash_screen.dart';
import 'package:domi_cafe/features/auth/presentation/screens/auth_screen.dart';
import 'package:domi_cafe/features/product_details/presentation/pages/product_details_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splash = '/';
  static const String layout = '/layout';
  static const String home = '/home';
  static const String auth = '/auth';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String productDetails = '/product_details'; // ← اضفت
}

class AppRoutes {
  static final AppRoutes instance = AppRoutes();

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<LayoutCubit>(create: (context) => LayoutCubit()),
            ],
            child: const HomeLayout(),
          ),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      // ← هنا اضفت حالة ProductDetails
      case Routes.productDetails:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(productId: productId),
          settings: settings,
        );

      default:
        return null;
    }
  }
}

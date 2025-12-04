import 'package:domi_cafe/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:domi_cafe/features/layout/presentation/screens/home_layout.dart';
import 'package:domi_cafe/features/orders/presentation/cubit/home_cubit.dart';
import 'package:domi_cafe/features/splash/presentation/screens/splash_screen.dart';
import 'package:domi_cafe/features/auth/presentation/screens/auth_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Routes {
  static const String splash = '/';
  static const String layout = '/layout';
  static const String home = '/home';
  static const String auth = '/auth';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String myOrders = '/myOrders';
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
              BlocProvider<LayoutCubit>(
                create: (_) => LayoutCubit(
                  userId: 'TEST_USER_UID', // TODO: Replace with real UID
                  firestore: FirebaseFirestore.instance,
                ),
              ),
              BlocProvider<HomeCubit>(
                create: (_) => HomeCubit(FirebaseFirestore.instance),
              ),
            ],
            child: const HomeLayout(),
          ),
          settings: settings,
        );

      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
          settings: settings,
        );

      default:
        return null;
    }
  }
}

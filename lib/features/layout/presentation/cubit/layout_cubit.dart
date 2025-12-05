import 'package:domi_cafe/core/utils/app_strings.dart';
import 'package:domi_cafe/features/favorit/presentation/screens/favorit_screen.dart';
import 'package:domi_cafe/features/home/presentation/screens/menu_screen.dart';
import 'package:domi_cafe/features/orders/presentation/cubit/home_cubit.dart';
import 'package:domi_cafe/features/orders/presentation/screens/my_orders.dart';
import 'package:domi_cafe/features/tables/presentation/screens/tables_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  final String userId;
  final FirebaseFirestore firestore;

  LayoutCubit({
    required this.userId,
    required this.firestore,
  }) : super(LayoutInitial());

  List<Map<IconData, String>> bottomNavItems = [
    {Icons.home: AppStrings.home},
    {Icons.category: AppStrings.categories},
    {Icons.shopping_cart: AppStrings.myCart},
    {Icons.person: AppStrings.account},
  ];

  int currentIndex = 0;

  /// استخدام getter لضمان إنشاء MyOrdersScreen بعد توفر userId
  List<Widget> get screens => [
        MenuScreen(),
        TablesScreen(),
        FavoritScreen(),
        BlocProvider(
          create: (_) => HomeCubit(firestore),
          child: MyOrdersScreen(userId: userId),
        ),
      ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}

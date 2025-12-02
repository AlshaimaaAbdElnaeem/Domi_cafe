import 'package:domi_cafe/core/utils/app_strings.dart';
import 'package:domi_cafe/features/favorit/presentation/screens/favorit_screen.dart';
import 'package:domi_cafe/features/home/presentation/screens/home_screen.dart';
import 'package:domi_cafe/features/home/presentation/screens/menu_screen.dart';
import 'package:domi_cafe/features/orders/presentation/screens/my_orders.dart';
import 'package:domi_cafe/features/tables/presentation/screens/tables_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  List<Map<IconData, String>> bottomNavItems = [
    {Icons.home: AppStrings.home},
    {Icons.category: AppStrings.categories},
    {Icons.shopping_cart: AppStrings.myCart},
    {Icons.person: AppStrings.account},
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    MenuScreen(),
    TablesScreen(),
    FavoritScreen(),
    MyOrdersScreen()
      ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}

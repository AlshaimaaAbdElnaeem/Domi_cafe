import 'package:domi_cafe/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    var theme = Theme.of(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return  FrostedBottomBar(
          bottomBarColor: theme.secondaryHeaderColor.withValues(
            alpha: 50,
          ),
          width: 250.w,
          sigmaX: 3,
         sigmaY: 3,
        borderRadius: BorderRadius.circular(25),
        opacity: 0.6,
         body: (BuildContext context, ScrollController controller) { 
          return  cubit.screens[cubit.currentIndex];
          },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            IconButton(
              icon:  Icon(Icons.home_outlined , size: 30.w,
              color: cubit.currentIndex == 0 ? theme.primaryColor : theme.iconTheme.color,
              ),
              onPressed: ()=>cubit.changeBottomNavIndex(0),
            ),
            IconButton(
              icon:  Icon(Icons.table_chart_outlined , size: 30.w,
              color: cubit.currentIndex == 1 ? theme.primaryColor : theme.iconTheme.color,
              ),
              onPressed: ()=>cubit.changeBottomNavIndex(1),
            ),
            IconButton(
              icon:  Icon(Icons.favorite_border , size: 30.w,
              color: cubit.currentIndex == 2 ? theme.primaryColor : theme.iconTheme.color,
              ),
              onPressed: ()=>cubit.changeBottomNavIndex(2),
            ),
            IconButton(onPressed: ()=>cubit.changeBottomNavIndex(3), icon: Icon(Icons.list_alt_outlined , size: 30.w,
              color: cubit.currentIndex == 3 ? theme.primaryColor : theme.iconTheme.color,
              ),),
            
          ],
        ),
       
      );
          }    );
  }
}
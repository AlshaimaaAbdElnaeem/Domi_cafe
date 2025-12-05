import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:domi_cafe/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return ScreenUtilInit(
     designSize: const Size(375, 812),
     minTextAdapt: true,
     splitScreenMode: true,
     builder: (context, child) {
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         // title: locale.tr(AppStrings.appName),
         theme: AppThemes.instance.lightTheme(context),           
         // supportedLocales: context.supportedLocales,
         // locale: context.locale,
         initialRoute: Routes.splash,
         onGenerateRoute: AppRoutes.instance.onGenerateRoute,
       );
     },
   );
  }
}

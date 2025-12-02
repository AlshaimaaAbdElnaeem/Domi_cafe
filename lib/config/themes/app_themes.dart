import 'package:domi_cafe/core/extinsions/extinsions.dart';
import 'package:domi_cafe/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static final AppThemes instance = AppThemes();

  /// -------------------------------------------------------
  /// LIGHT THEME
  /// -------------------------------------------------------
  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      splashFactory: NoSplash.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimary,
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightPrimaryHover,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
      ),

      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        toolbarHeight: context.width / context.height >= 0.6 ? 60.h : null,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.lightHeading,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.lightHeading,
          size: context.width / context.height >= 0.6 ? 30.h : 20.h,
        ),
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lightText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.lightText,
        ),
        headlineMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.lightHeading,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.lightText.withOpacity(.6),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInput,
        hintStyle: TextStyle(color: AppColors.lightText.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightInputBorder),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightPrimary),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 1,
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  /// -------------------------------------------------------
  /// DARK THEME
  /// -------------------------------------------------------
  ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,

      splashFactory: NoSplash.splashFactory,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkPrimary,
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkPrimaryHover,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
      ),

      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        toolbarHeight: context.width / context.height >= 0.6 ? 60.h : null,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.darkHeading,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.darkHeading,
          size: context.width / context.height >= 0.6 ? 30.h : 20.h,
        ),
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.darkText,
        ),
        headlineMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.darkHeading,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.darkText.withOpacity(.6),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInput,
        hintStyle: TextStyle(color: AppColors.darkText.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkInputBorder),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkPrimary),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 1,
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.darkPrimary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

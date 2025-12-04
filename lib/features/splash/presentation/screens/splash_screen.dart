import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:domi_cafe/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.auth,
          (route) => false,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          fit: BoxFit.contain,
          width: 150.w,
          height: 150.h,
        ),
      ),
    );
  }
}

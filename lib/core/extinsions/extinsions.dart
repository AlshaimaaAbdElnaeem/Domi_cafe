import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Sizer on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension Spacer on double {
  SizedBox get sH => SizedBox(height: this.h);

  SizedBox get sW => SizedBox(width: this.w);
}

extension ValidatePhoneNumber on String {
  bool get isValidEgyptPhone =>
      RegExp(r'^(?:\+20|0)1[0125]\d{8}$').hasMatch(this);
}

extension ValidateEmail on String {
  bool get isValidEmail {
    return RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(this);
  }
}

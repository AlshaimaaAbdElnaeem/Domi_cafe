import 'package:domi_cafe/core/utils/app_colors.dart';
import 'package:domi_cafe/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppConstants {
  static final AppConstants instance = AppConstants();

  Future<void> showAnimatedDialog(
    BuildContext context,
    String contentText,
    bool isConfirmationDialog, [
    Function()? onConfirm,
  ]) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      barrierLabel: '',
      pageBuilder: (_, __, ___) {
        return const SizedBox();
      },
      transitionBuilder: (_, animation, __, ___) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0, -0.2),
                end: const Offset(0, 0),
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(12.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10).w,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    contentText,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 20.h),
                  isConfirmationDialog == false
                      ? SizedBox(
                        height: 40.h,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            if (onConfirm != null) {
                              Navigator.of(context).pop();
                              onConfirm();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            height: 40.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10).w,
                              border: Border.all(
                                color: AppColors.darkPrimary,
                                width: 1.w,
                              ),
                            ),
                            child:
                                Text(
                                  AppStrings.confirm,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppColors.darkPrimary),
                                ),
                          ),
                        ),
                      )
                      : SizedBox(
                        height: 40.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10).w,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 1.w,
                                    ),
                                  ),
                                  child:
                                      Text(
                                        AppStrings.cancel,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white),
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (onConfirm != null) {
                                    Navigator.of(context).pop();
                                    onConfirm();
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  height: 40.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10).w,
                                    border: Border.all(
                                      color: AppColors.darkPrimary,
                                      width: 1.w,
                                    ),
                                  ),
                                  child:
                                      Text(
                                        AppStrings.confirm,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: AppColors.darkPrimary,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showDatePickerDialog(
    BuildContext context, {
    required DateTime initialDate,
    required Function(DateTime) onDateSelected,
    required DateTime currentDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      currentDate: currentDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.lightPrimary,
            colorScheme: ColorScheme.light(primary: AppColors.lightPrimary),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.lightPrimary,
              selectionColor: AppColors.lightPrimary.withOpacity(0.3),
              selectionHandleColor: AppColors.lightPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightPrimary,
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          child: Center(
            child: Container(
              width: 330.w,
              height: 500.h,
              padding: EdgeInsets.all(8.w),
              child: child!,
            ),
          ),
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        onDateSelected(selectedDate);
      }
    });
  }
}

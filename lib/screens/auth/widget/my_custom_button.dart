import 'package:flutter/material.dart';
import 'package:full_pay/utils/colors/app_colors.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {super.key,
      required this.onTap,
      this.readyToSubmit = true,
      this.isLoading = false,
      required this.title});

  final VoidCallback onTap;
  final bool readyToSubmit;
  final bool isLoading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            backgroundColor:
                readyToSubmit ? AppColors.c_1A72DD : AppColors.c_C4C4C4),
        onPressed: readyToSubmit ? onTap : null,
        child: Center(
            child: isLoading
                ? SizedBox(
                    height: 36.h,
                    width: 36.h,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 5,
                    ))
                : Text(
                    title,
                    style: AppTextStyle.interSemiBold.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
      ),
    );
  }
}

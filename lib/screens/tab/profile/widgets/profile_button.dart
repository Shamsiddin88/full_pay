import 'package:flutter/material.dart';
import 'package:full_pay/utils/colors/app_colors.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
        required this.onTap,
        required this.title, required this.iconPath});

  final VoidCallback onTap;
  final String title;
  final IconData iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              backgroundColor:
              AppColors.c_1A72DD ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconPath, color: Colors.white,),
              15.getW(),
              Text(
                title,
                style: AppTextStyle.interSemiBold.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

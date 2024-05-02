import 'package:flutter/material.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';


class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Image.asset(AppImages.onBoardingOne),
        ),
        24.getH(),
        Text("To'g'ri munosabatlar hamma narsadan ustun", style: AppTextStyle.interBold.copyWith(fontSize: 25.w),textAlign: TextAlign.center,),
          24.getH(),
          Text("Moliyaviy muvaffaqiyatdagi ishonchli hamkoringiz", style: AppTextStyle.interThin.copyWith(fontSize: 18.w),textAlign: TextAlign.center,)

      ],),
    );
  }
}

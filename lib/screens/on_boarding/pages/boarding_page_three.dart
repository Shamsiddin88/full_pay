import 'package:flutter/material.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';


class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(AppImages.onBoardingThree),
          ),
          24.getH(),
          Text("Sizning moliyaviy muvaffaqiyatingiz uchun keng qamrovli manba", style: AppTextStyle.interBold.copyWith(fontSize: 25.w),textAlign: TextAlign.center,),
          24.getH(),
          Text("Moliyaviy maqsadlaringiz uchun to'g'ri tanlov", style: AppTextStyle.interThin.copyWith(fontSize: 18.w),textAlign: TextAlign.center,)

        ],),
    );
  }
}

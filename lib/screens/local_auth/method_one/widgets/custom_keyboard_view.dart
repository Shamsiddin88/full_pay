import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class CustomKeyboardView extends StatelessWidget {
  const CustomKeyboardView(
      {super.key,
      required this.number,
      required this.isBiometricsEnabled,
      required this.onClearButtonTap, required this.onFingerPrintTap});

  final ValueChanged<String> number;
  final bool isBiometricsEnabled;
  final VoidCallback onClearButtonTap;
  final VoidCallback onFingerPrintTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 32,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
        children: [
          ...List.generate(9, (index) {
            return IconButton(
                onPressed: () {
                  number.call("${index + 1}");
                },
                icon: Text(
                  "${index + 1}",
                  style: AppTextStyle.interBold.copyWith(fontSize: 24),
                ));
          }),
          Visibility(
              visible: isBiometricsEnabled,
              child: IconButton(onPressed: onFingerPrintTap,icon: Icon(Icons.fingerprint, size: 45,))),
          IconButton(
              onPressed: () {
                number.call("0");
              },
              icon: Text(
                "0",
                style: AppTextStyle.interBold.copyWith(fontSize: 24),
              )),
          IconButton(onPressed: onClearButtonTap, icon: Icon(Icons.backspace_rounded)),

        ],
      ),
    );
  }
}

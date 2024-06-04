import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/colors/app_colors.dart';

class EditTextInput extends StatelessWidget {
  const EditTextInput(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.type,
        required this.regExp,
        required this.errorTitle,
        this.onChanged,
        this.inputFormatter});

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final RegExp regExp;
  final String errorTitle;
  final ValueChanged<String>? onChanged;
  final TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          controller: controller,
          keyboardType: type,
          validator: (String? value) {
            if (value == null ||
                value.isEmpty ||
                value.length < 3 ||
                !regExp.hasMatch(value)) {
              return errorTitle;
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [if(inputFormatter!=null) inputFormatter!],
          decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColorLight,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              prefixIconColor: AppColors.c_1A72DD,
              contentPadding: const EdgeInsets.all(16),
              labelText: hintText,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(12)),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(12))),
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}
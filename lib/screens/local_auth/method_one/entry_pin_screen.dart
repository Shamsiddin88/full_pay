import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/app/app.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/auth/auth_state.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/local/storage_repository.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/local_auth/method_one/widgets/custom_keyboard_view.dart';
import 'package:full_pay/screens/local_auth/method_one/widgets/pin_put_view.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/services/biometric_auth_service.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';

class EntryPinScreen extends StatefulWidget {
  const EntryPinScreen({super.key});

  @override
  State<EntryPinScreen> createState() => _EntryPinScreenState();
}

class _EntryPinScreenState extends State<EntryPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  bool isError = false;
  String currentPin = "";
  bool biometricsEnabled = false;
  int attemptCount = 0;

  @override
  void initState() {
    biometricsEnabled =
        StorageRepository.getBool(key: AppConstants.biometricsEnabled);
    currentPin = StorageRepository.getString(key: AppConstants.pinCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height / 10,
        ),
        Text("Pin kodni kiriting",
          style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),),
        SizedBox(height: 32.h,),
        SizedBox(
          width: width / 2,
          child: PinPutTextView(
              isError: isError,
              pinPutController: pinPutController,
              pinPutFocusNode: focusNode
          ),
        ),
        SizedBox(height: 32.h,),
        CustomKeyboardView(
            onFingerPrintTap: checkBiometrics,
            number: (number) {
              if (pinPutController.length < 4) {
                isError = false;
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (currentPin == pinPutController.text) {
                  Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
                }
                else {
                  attemptCount++;
                  if (attemptCount == 3) {
                    context.read<AuthBloc>().add(LogOutUserEvent());
                  }
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: biometricsEnabled,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                    0, pinPutController.text.length - 1);
              }
            }
        ),

        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state.status == FormsStatus.unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.authRoute, (route) => false);
          }
        }, child: const SizedBox(),)

      ],),);
  }

  Future <void> checkBiometrics () async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }

  }
}

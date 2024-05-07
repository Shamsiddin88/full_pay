import 'package:flutter/material.dart';
import 'package:full_pay/data/local/storage_repository.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/services/biometric_auth_service.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/project_extensions.dart';

class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TouchID SCreeen"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 250.h,
              color: Colors.blue,
            ),
            40.getH(),
            MyCustomButton(
                onTap: enableBiometrics,
                title: "Biometric Auth"),
            32.getH(),
            MyCustomButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.tabRoute, (route) => false);
                },
                title: "Skip"),
          ],
        ),
      ),
    );
  }

  Future <void> enableBiometrics () async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(
        key: AppConstants.biometricsEnabled,
        value: true,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Biometrics Enabled")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Biometrics Error")));
    }
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.tabRoute, (route) => false);
  }
}

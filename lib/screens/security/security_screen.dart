import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_pay/data/local/storage_repository.dart';
import 'package:full_pay/screens/security/widgets/security_button.dart';
import 'package:full_pay/services/biometric_auth_service.dart';
import 'package:full_pay/utils/constants/app_constants.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SecurityButton(
                isEnabled: StorageRepository.getBool(
                    key: AppConstants.biometricsEnabled),
                onTap: () async {
                  bool isEnabled = StorageRepository.getBool(
                      key: AppConstants.biometricsEnabled);

                  if (isEnabled) {
                    await StorageRepository.setBool(
                        key: AppConstants.biometricsEnabled, value: false);
                  }
                  else{
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
                    }
                  setState(() {
                  });

                })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricAuthService {
  static LocalAuthentication auth = LocalAuthentication();

  static Future <bool> canAuthenticate() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate = canAuthenticateWithBiometrics ||
        await auth.isDeviceSupported();

    if (canAuthenticate) {
      List <BiometricType> types = await auth.getAvailableBiometrics();
      if (types.isNotEmpty) return true;
    }
    return false;
  }

  static Future <bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: "Barmoq izi yoki yuzni tanlash usulini faollashtirirng!",
        options: const AuthenticationOptions(
            useErrorDialogs: false, stickyAuth: true, biometricOnly: true),);
    } on PlatformException catch (e) {
      if (e.code==auth_error.notAvailable){}
      else if (e.code == auth_error.notEnrolled){}
      else {}
      return false;
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/local/storage_repository.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/utils/colors/app_colors.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasPin = false;

  _init(bool isAuthenticated) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (!mounted) return;

    if (isAuthenticated == false) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.authRoute);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    } else {
      Navigator.pushReplacementNamed(
          context, hasPin ? RouteNames.entryPinRoute : RouteNames.setPinRoute);
    }
  }

  @override
  void initState() {
    hasPin = StorageRepository.getString(key: AppConstants.pinCode).isNotEmpty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == FormsStatus.authenticated) {
          BlocProvider.of<UserProfileBloc>(context)
              .add(GetCurrentUserEvent(FirebaseAuth.instance.currentUser!.uid));
          _init(true);
        } else {
          _init(false);
        }
      },
      child: Stack(
        children: [
          Image.asset(
            AppImages.splashBackground,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppImages.dottedMap,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: height / 2.5,
            child: Column(
              children: [
                SvgPicture.asset(AppImages.fullIcon),
                10.getH(),
                Text(
                  "FullPay",
                  style: AppTextStyle.interBold
                      .copyWith(color: AppColors.white, fontSize: 20.w),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

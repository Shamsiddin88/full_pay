import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/auth/auth_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/repositories/user_profile_repository.dart';
import 'package:full_pay/screens/auth/register_screen.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/auth/widget/password_text_input.dart';
import 'package:full_pay/screens/auth/widget/universal_text_input.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/utils/colors/app_colors.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/images/app_images.dart';
import 'package:full_pay/utils/project_extensions.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

bool isChecked = false;

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(userNameController.text);

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.login,
                        height: 300.h,
                        fit: BoxFit.cover,
                      ),
                      16.getH(),
                      Text("KIRISH",
                          style: Theme.of(context).textTheme.bodyLarge),
                      UniversalTextInput(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: userNameController,
                        hintText: "Username",
                        type: TextInputType.text,
                        regExp: AppConstants.textRegExp,
                        errorTitle: "Username noto'g'ri",
                        iconPath: AppImages.profile,
                      ),
                      20.getH(),
                      PasswordTextInput(
                        onChanged: (v) {
                          setState(() {});
                        },
                        controller: passwordController,
                      ),
                      13.getH(),
                      Row(
                        children: [
                          Switch(
                            value: isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                          3.getW(),
                          Text(
                            "Eslab qolish",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Parolni unutdingizmi?",
                                style: Theme.of(context).textTheme.labelSmall,
                              ))
                        ],
                      ),
                      13.getH(),
                      MyCustomButton(
                          onTap: () {
                            context.read<AuthBloc>().add(LoginUserEvent(
                                password: passwordController.text,
                                username: userNameController.text));
                          },
                          readyToSubmit: isValidLoginCredentials(),
                          isLoading: state.status == FormsStatus.loading,
                          title: "Login"),
                      13.getH(),
                      Text("YOKI",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 14)),
                      10.getH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                context.read<AuthBloc>()
                                  ..add(SignInWithGoogleEvent());
                              },
                              icon: SvgPicture.asset(
                                AppImages.google,
                                height: 24.h,
                              )),
                          Text("orqali kirish",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 12)),
                        ],
                      ),
                      13.getH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ro'yxatdan o'tmaganmisiz?"),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.registerRoute);
                                },
                                child: Text(
                                  "Ro'yxatdan o'tish",
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
            },
            listener: (context, state) {
              if (state.status == FormsStatus.error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if (state.status == FormsStatus.authenticated) {
                if (state.statusMessage == "registered") {
                  BlocProvider.of<UserProfileBloc>(context)
                      .add(AddUserEvent(state.userModel));
                }
                else {
                  BlocProvider.of<UserProfileBloc>(context)
                      .add(GetCurrentUserEvent(state.userModel.authUid));
                }
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.setPinRoute, (route) => false);
              }
            },
          ),
        ));
  }
}

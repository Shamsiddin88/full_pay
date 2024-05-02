import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/auth/auth_state.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/data/models/user_model.dart';
import 'package:full_pay/screens/auth/auth_screen.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/auth/widget/password_text_input.dart';
import 'package:full_pay/screens/auth/widget/universal_text_input.dart';
import 'package:full_pay/screens/tab/home/home_screen.dart';
import 'package:full_pay/utils/colors/app_colors.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/project_extensions.dart';
import '../../utils/images/app_images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

bool isChecked = false;

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isValidLoginCredentials() =>
      AppConstants.passwordRegExp.hasMatch(passwordController.text) &&
      AppConstants.textRegExp.hasMatch(userNameController.text) &&
      AppConstants.phoneRegExp.hasMatch(phoneNumberController.text) &&
      AppConstants.passwordRegExp.hasMatch(confirmPasswordController.text) &&
      AppConstants.textRegExp.hasMatch(lastNameController.text);

  @override
  void dispose() {
    phoneNumberController.dispose();
    userNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset(
                                AppImages.welcome,
                                height: 250.h,
                              ),
                            ),
                            16.getH(),
                            Text("Ro'yxatdan o'tish",
                                style: Theme.of(context).textTheme.bodyLarge),
                            16.getH(),
                            UniversalTextInput(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: userNameController,
                              hintText: "Ism",
                              type: TextInputType.text,
                              regExp: AppConstants.textRegExp,
                              errorTitle: "Ism noto'g'ri",
                              iconPath: AppImages.profile,
                            ),
                            16.getH(),
                            UniversalTextInput(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: lastNameController,
                              hintText: "Familiya",
                              type: TextInputType.text,
                              regExp: AppConstants.textRegExp,
                              errorTitle: "Familiya noto'g'ri",
                              iconPath: AppImages.profile,
                            ),
                            16.getH(),
                            UniversalTextInput(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: phoneNumberController,
                              hintText: "Telefon",
                              type: TextInputType.phone,
                              regExp: AppConstants.phoneRegExp,
                              errorTitle: "Telefon noto'g'ri",
                              iconPath: AppImages.phone,
                            ),
                            16.getH(),
                            PasswordTextInput(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: passwordController,
                            ),
                            16.getH(),
                            PasswordTextInput(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: confirmPasswordController,
                            ),
                            13.getH(),
                            MyCustomButton(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(RegisterUserEvent(
                                          userModel: UserModel(
                                        username: userNameController.text,
                                        password: passwordController.text,
                                        lastname: lastNameController.text,
                                        email:
                                            "${userNameController.text}@gmail.com"
                                                .trim(),
                                        imageUrl: "",
                                        phoneNumber: phoneNumberController.text,
                                        userId: "",
                                      )));
                                },
                                title: "Register"),
                            13.getH(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Oldin ro'yxatdan o'tganmisiz?"),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Kirish"))
                              ],
                            )
                          ],
                        ),
                      ))

            );
          },
          listener: (context, state) {
            if (state.status == FormsStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
        ),
      ),
    );
  }
}

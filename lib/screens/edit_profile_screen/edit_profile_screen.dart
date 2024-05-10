import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/models/user_model.dart';
import 'package:full_pay/screens/auth/widget/my_custom_button.dart';
import 'package:full_pay/screens/edit_profile_screen/widget/edit_text_input.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/utils/constants/app_constants.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  late UserModel userModel;

  @override
  void initState() {
    userModel = context.read<UserProfileBloc>().state.userModel;
    phoneNumberController.text=userModel.phoneNumber;
    userNameController.text=userModel.username;
    lastNameController.text=userModel.lastname;
    setState(() {
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(),body: BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              30.getH(),
              Text("Edit Profile", style: AppTextStyle.interBold.copyWith(fontSize: 24),),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                        CachedNetworkImage(
                          imageUrl: state.userModel.imageUrl.isEmpty
                              ? "https://img.freepik.com/premium-vector/3d-realistic-person-people_165488-4529.jpg"
                              : state.userModel.imageUrl,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    TextButton(onPressed: (){}, child: Text("Change Profile Picture", style: AppTextStyle.interMedium.copyWith(fontSize: 18),))
                  ],
                ),
              ),
                10.getH(),
                EditTextInput(controller: userNameController, hintText: "Name", type: TextInputType.text, regExp: AppConstants.textRegExp, errorTitle: "Name"),
                EditTextInput(controller: lastNameController, hintText: "Lastname", type: TextInputType.text, regExp: AppConstants.textRegExp, errorTitle: "Last Name"),
                EditTextInput(controller: phoneNumberController, hintText: "Phone number", type: TextInputType.phone, regExp: AppConstants.phoneRegExp, errorTitle: "Phone"),
                20.getH(),
                MyCustomButton(onTap: (){
                  UserModel updatedUserModel = state.userModel;

                  print("USERNAME${updatedUserModel.username}");

                  updatedUserModel=updatedUserModel.copyWith(username: userNameController.text, lastname: lastNameController.text, phoneNumber: phoneNumberController.text);
                  context.read<UserProfileBloc>().add(UpdateUserEvent(updatedUserModel));
                  Navigator.pop(context);
                }, title: "Save"),

            ],),
          ),
        );
      },
    ),);
  }
}

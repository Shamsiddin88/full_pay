import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_pay/blocs/auth/auth_bloc.dart';
import 'package:full_pay/blocs/auth/auth_event.dart';
import 'package:full_pay/blocs/auth/auth_state.dart';
import 'package:full_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:full_pay/data/forms_status.dart';
import 'package:full_pay/screens/routes.dart';
import 'package:full_pay/screens/tab/profile/widgets/profile_button.dart';
import 'package:full_pay/utils/project_extensions.dart';
import 'package:full_pay/utils/styles/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
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
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    30.getH(),
                    Text(
                      "${state.userModel.username} ${state.userModel.lastname}",
                      style: AppTextStyle.interBold,
                    ),
                    Text(
                      state.userModel.phoneNumber,
                      style: AppTextStyle.interBold,
                    ),
                    ProfileButton(
                      onTap: () {
                        context.read<UserProfileBloc>()
                          .add(GetUserByDocIdEvent(
                              docId: state.userModel.userId));

                        Navigator.pushNamed(
                            context, RouteNames.editProfileRoute);
                      },
                      title: "Edit profile",
                      iconPath: Icons.edit,
                    ),
                    ProfileButton(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.securityRoute);
                      },
                      title: "Security",
                      iconPath: Icons.security,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.status == FormsStatus.unauthenticated) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteNames.authRoute, (route) => false);
                        }
                      },
                      child: TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(LogOutUserEvent());
                          },
                          child: const Text("Log out")),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

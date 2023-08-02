import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../repository/firebase_storage/firebase_storage_config.dart';
import '../../utils/app_utils.dart';
import '../../widgets/custom_text_form_field_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/title_app_bar.dart';
import '../auth_pages/login_page.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fAuth = FirebaseAuth.instance;
    TextEditingController nameC = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const TitleAppBar(leftText: "Edit", rightText: "Profile")),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200.h,
                  child: Stack(children: [
                    Container(
                        color: AppUtils.appbarBackgroundColor,
                        width: MediaQuery.of(context).size.width,
                        height: 100.h),
                    Positioned(
                        left: 130.w,
                        top: 30.h,
                        child: Column(children: [
                          CircleAvatar(
                              radius: 58,
                              backgroundImage: NetworkImage(
                                  "${fAuth.currentUser?.photoURL}"),
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.white70,
                                        child: IconButton(
                                            onPressed: () async {
                                              await FirebaseStorageConfig()
                                                  .pickImage(context);
                                            },
                                            icon: const Icon(Icons.camera))))
                              ])),
                          const SizedBox(height: 10.0),
                          BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                            if (state is UnAuthenticated) {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: const LoginPage(), withNavBar: false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            }
                          }, builder: (context, state) {
                            if (state is Loading) {
                              return const LoadingWidget(count: 1);
                            }
                            return _buttonProfile(context,
                                labelButton: "Logout",
                                onPressed: () => _customShowDialog(
                                      context,
                                      content: "Are you sure want to Logout ?",
                                      labelButton: "Logout",
                                      onTap: () => context.read<AuthBloc>()
                                        ..add(SignOutRequested()),
                                    ));
                          })
                        ]))
                  ])),
              Center(
                  child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
                if (state is UnAuthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                }
              }, builder: (context, state) {
                if (state is Loading) {
                  return const LoadingWidget(count: 1);
                }
                return _buttonProfile(context, labelButton: "Delete Account",
                    onPressed: () {
                  _customShowDialog(context,
                      content: "Are you sure you want to Delete this Account?",
                      labelButton: "Delete Account",
                      onTap: () => context.read<AuthBloc>()..add(DeleteUser()));
                });
              })),
              const SizedBox(height: 10.0),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)));
                            }
                          },
                          builder: (context, state) {
                            if (state is Loading) {
                              return const LoadingWidget(count: 1);
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Name :  ${fAuth.currentUser?.displayName}",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                IconButton(
                                    onPressed: () => _customModalBottomSheet(
                                        context,
                                        label: "Change your name?",
                                        textEditingController: nameC,
                                        onPressed: () => _customShowDialog(
                                                context,
                                                content:
                                                    "Are you sure want to change your Name?",
                                                onTap: () {
                                              context.read<AuthBloc>().add(
                                                  UpdateDisplayName(
                                                      nameC.text));
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }, labelButton: "Save"),
                                        icon: Icons.person),
                                    icon: const Icon(Icons.edit,
                                        color: AppUtils.appbarBackgroundColor))
                              ],
                            );
                          },
                        ),
                        const Divider(),
                        const SizedBox(height: 20.0),
                        Text("Email :  ${fAuth.currentUser?.email}",
                            style: Theme.of(context).textTheme.titleLarge),
                        const Divider(),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Password :  ****",
                                style: Theme.of(context).textTheme.titleLarge),
                            IconButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, "/changePassword"),
                                icon: const Icon(Icons.edit,
                                    color: AppUtils.appbarBackgroundColor))
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 20),
                        fAuth.currentUser!.emailVerified == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Email has been Verified",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  IconButton(
                                      onPressed: () async {
                                        await fAuth.currentUser
                                            ?.sendEmailVerification();
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "an Verification Email has been Send to your Email. Please Check your Email."),
                                                  duration:
                                                      Duration(seconds: 2)));
                                        }
                                      },
                                      icon: const Icon(Icons.cancel_outlined,
                                          color: Colors.red))
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Text("Email has been Verified",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    IconButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Your Email has been Verified"),
                                            duration: Duration(seconds: 2),
                                          ));
                                        },
                                        icon: const Icon(Icons.check,
                                            color: Colors.green))
                                  ]),
                        const Divider(),
                        const SizedBox(height: 10.0)
                      ]))
            ]))));
  }

  Future<dynamic> _customShowDialog(BuildContext context,
      {required String content,
      required String labelButton,
      void Function()? onTap}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Notifications"),
              elevation: 2,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  color: Colors.grey),
              content: Text(content),
              actionsPadding: const EdgeInsets.all(20.0),
              actions: [
                _buttonProfile(context,
                    onPressed: () => Navigator.pop(context),
                    labelButton: "Cancel"),
                _buttonProfile(context,
                    onPressed: onTap, labelButton: labelButton)
              ]);
        });
  }

  TextButton _buttonProfile(BuildContext context,
      {void Function()? onPressed, required String labelButton}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: AppUtils.appbarBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(labelButton,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)));
  }

  Future<dynamic> _customModalBottomSheet(
    BuildContext context, {
    required String label,
    required textEditingController,
    required IconData icon,
    void Function()? onPressed,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Theme.of(context).cardColor),
                  height: 190.h,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextFormFieldWidget(
                          label: label,
                          textEditingController: textEditingController,
                          icon: icon),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: onPressed, child: const Text("Save")),
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }
}

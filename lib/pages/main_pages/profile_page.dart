import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/pages/export_pages.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../blocs/export_blocs.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fAuth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const TitleAppBar(leftText: "Profile", rightText: "Screen"),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined))
            ]),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 240.h,
                  child: Stack(children: [
                    Container(
                        color: AppUtils.appbarBackgroundColor,
                        width: MediaQuery.of(context).size.width,
                        height: 130.h),
                    Positioned(
                        left: 130.w,
                        top: 30.h,
                        child: Column(children: [
                          CircleAvatar(
                              radius: 58,
                              backgroundImage: NetworkImage(
                                  "${fAuth.currentUser?.photoURL}")),
                          const SizedBox(height: 10.0),
                          _buttonProfile(context,
                              labelButton: "Edit Profile",
                              onPressed: () =>
                                  PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const EditProfileScreen(),
                                      withNavBar: false)),
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
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: const Text("Notifications"),
                                          elevation: 2,
                                          titleTextStyle: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20.0,
                                              color: Colors.grey),
                                          content: const Text(
                                              "Are you sure want to Logout?"),
                                          actionsPadding:
                                              const EdgeInsets.all(20.0),
                                          actions: [
                                            _buttonProfile(context,
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                labelButton: "Cancel"),
                                            _buttonProfile(context,
                                                onPressed: () =>
                                                    context.read<AuthBloc>()
                                                      ..add(SignOutRequested()),
                                                labelButton: "Logout")
                                          ]);
                                    }));
                          })
                        ]))
                  ])),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ${fAuth.currentUser?.displayName}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppUtils.appbarBackgroundColor),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _listTileCard(context,
                                      title: 'My Profile', icons: Icons.person);
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: 5)),
                        const SizedBox(height: 10.0)
                      ]))
            ]))));
  }

  TextButton _buttonProfile(BuildContext context,
      {void Function()? onPressed, required String labelButton}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: AppUtils.appbarBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(labelButton,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)));
  }

  ListTile _listTileCard(BuildContext context,
      {void Function()? onTap,
      required String title,
      required IconData icons,
      Widget? trailing}) {
    return ListTile(
        minVerticalPadding: 10,
        minLeadingWidth: 20,
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: Icon(icons),
        textColor: Colors.white,
        iconColor: Colors.white,
        onTap: onTap,
        trailing: trailing ?? const SizedBox());
  }
}

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/blocs/set_weekly_goal_bloc/set_weekly_goal_bloc.dart';
import 'package:fitness_app/pages/set_reminder_page.dart';
import 'package:fitness_app/pages/set_weekly_goal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/my_training_bloc/my_training_bloc.dart';
import '../../utils/app_utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/title_app_bar.dart';
import '../auth_pages/login_page.dart';
import '../person_pages/edit_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fAuth = FirebaseAuth.instance;

    const double sizeI = 28;

    final lWobject = [
      WObject(
          name: "Reminder",
          icon: const Icon(Icons.timer, size: sizeI),
          onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
              screen: const SetReminderPage(), withNavBar: false)),
      WObject(
          name: "Clear Custom Training",
          icon: const Icon(Icons.person, size: sizeI),
          onTap: () async {
            await _customShowDialog(context,
                content: "Are you sure you want to clear all Custom Training?",
                labelButton: "Clear All");
          }),
      WObject(
          name: "Set Training Days",
          icon: const Icon(Icons.transfer_within_a_station_sharp, size: sizeI),
          onTap: () async {
            context.read<SetWeeklyGoalBloc>().add(SetWeeklyNavigate());
            await PersistentNavBarNavigator.pushNewScreen(context,
                screen: const SetWeeklyGoalPage(), withNavBar: false);
          }),
    ];

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const TitleAppBar(leftText: "Profile", rightText: "Screen")),
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
                                    screen: const LoginPage(),
                                    withNavBar: false);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
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
                                                  onPressed: () => context
                                                      .read<AuthBloc>()
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
                        "Me",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Card(
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                  "Name : ${fAuth.currentUser!.displayName}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Email :  ${fAuth.currentUser!.email}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Last Signin :  ${DateFormat.Hms().format(fAuth.currentUser!.metadata.lastSignInTime!)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Created on :  ${DateFormat.yMMMMd().format(fAuth.currentUser!.metadata.creationTime!)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge)
                                            ])))
                              ]))),
                      const SizedBox(height: 10.0),
                      Card(
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "WORKOUT",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.blue),
                                    ),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            splashColor:
                                                AppUtils.appbarBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            leading: lWobject[index].icon,
                                            title: Text(lWobject[index].name),
                                            horizontalTitleGap: 20,
                                            onTap: lWobject[index].onTap,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount: lWobject.length)
                                  ]))),
                      const SizedBox(height: 50),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
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

  Future<dynamic> _customShowDialog(
    BuildContext context, {
    required String content,
    required String labelButton,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Clear Custom Training"),
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
                _buttonProfile(context, onPressed: () {
                  context.read<MyTrainingBloc>().add(ClearAllTraining());
                  Navigator.pop(context);
                }, labelButton: labelButton)
              ]);
        });
  }
}

class WObject extends Equatable {
  final String name;
  final Icon icon;
  final void Function()? onTap;

  const WObject({required this.name, required this.icon, this.onTap});

  @override
  List<Object?> get props => [icon, name, onTap];
}

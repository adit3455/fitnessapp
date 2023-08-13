import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../pages/home_pages/home_page.dart';
import '../pages/main_pages/profile_page.dart';
import '../pages/main_pages/reports_page.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _customShowDialog(context,
            content: "Are you sure you want to close this app?",
            button: _buttonProfile(
              context,
              labelButton: "Close App",
              onPressed: () {
                SystemNavigator.pop();
              },
            ));
        return false;
      },
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: PersistentTabController(initialIndex: 0),
          screens: const [HomePage(), ReportsPage(), ProfilePage()],
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.home),
              title: ("Home"),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: AppUtils.appbarBackgroundColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.assessment_rounded),
              title: ("Reports"),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: AppUtils.appbarBackgroundColor,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.person),
              title: ("Profile"),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: AppUtils.appbarBackgroundColor,
            ),
          ],
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
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
    required Widget button,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Alert"),
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
                button
              ]);
        });
  }
}

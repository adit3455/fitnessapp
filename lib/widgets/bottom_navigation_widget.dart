import 'package:fitness_app/pages/export_pages.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: PersistentTabController(initialIndex: 0),
        screens: const [
          HomePage(),
          DiscoverPage(),
          ReportsPage(),
          ProfilePage()
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: ("Home"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: AppUtils.appbarBackgroundColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.apps_rounded),
            title: ("Discover"),
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
    );
  }
}

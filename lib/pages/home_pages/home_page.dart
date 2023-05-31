import 'package:fitness_app/pages/discover_pages/workout_before_18.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/export_widgets.dart';
import '../export_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBar(leftText: "Fitness", rightText: "App"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0.h),
              const WeeklyReminderWidget(
                  image: AssetsUtil.peopleExerciseForWeekly,
                  title: "Set weekly goal for your Workout to max!",
                  trailing: CustomContainerButton(
                    iconData: Icons.add,
                  )),
              const RowMainSpaceBetweenText(
                  left: "Today Workout Plan", right: 'Mon 26 Apr'),
              StartFitnessWidget(
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const AllExercisesPage(), withNavBar: false)),
              SizedBox(height: 10.h),
              Text("Tips that might be usefull for you",
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 10.h),
              CustomCardHomePage(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const WorkOutBeforeEighteenPage(),
                      withNavBar: false),
                  image: AssetsUtil.eighteenPerson,
                  labelText: "Work out before age 18!"),
              SizedBox(height: 10.h),
              CustomCardHomePage(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const NutritionScreen(),
                      withNavBar: false),
                  image: AssetsUtil.nutritionFood,
                  labelText: "Sugestion the best food for You!"),
              SizedBox(height: 10.h),
              CustomCardHomePage(
                  image: AssetsUtil.stopSmoking,
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const BadHabbitsPage(),
                      withNavBar: false),
                  labelText: "Stay away from bad habits!"),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> exerciseToMap(exercise) {
    return {"listExercise": exercise};
  }
}

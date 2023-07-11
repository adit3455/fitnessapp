import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../utils/assets_util.dart';
import '../../widgets/custom_card_homepage.dart';
import '../../widgets/custom_container_button.dart';
import '../../widgets/row_main_space_between_text.dart';
import '../../widgets/start_fitness_widget.dart';
import '../../widgets/title_app_bar.dart';
import '../../widgets/weekly_reminder_home_widget.dart';
import '../discover_pages/bad_habbits_page.dart';
import '../discover_pages/nutritions_page.dart/nutrition_screen.dart';
import '../discover_pages/workout_before_18.dart';
import '../exercises_pages/exercise_tracker_page.dart';

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
              RowMainSpaceBetweenText(
                  left: "Today Workout Plan",
                  right: DateFormat.yMMMMEEEEd().format(DateTime.now())),
              StartFitnessWidget(
                  title: "Ready to Start",
                  onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const ExerciseTrackerPage(), withNavBar: false)),
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
}

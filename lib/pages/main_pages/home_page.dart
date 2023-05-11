import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/export_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBar(),
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
              const WeeklyReminderWidget(),
              const RowMainSpaceBetweenText(
                  left: "Today Workout Plan", right: 'Mon 26 Apr'),
              StartFitnessWidget(
                onTap: () {},
              ),
              SizedBox(height: 10.h),
              Text("Tips that might be usefull for you",
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 10.h),
              CustomCardHomePage(
                  onPressed: () {},
                  image: AssetsUtil.eighteenPerson,
                  labelText: "Work out before age 18!"),
              SizedBox(height: 10.h),
              const CustomCardHomePage(
                  image: AssetsUtil.nutritionFood,
                  labelText: "Sugestion the best food for You!"),
              SizedBox(height: 10.h),
              const CustomCardHomePage(
                  image: AssetsUtil.stopSmoking,
                  labelText: "Stay away from bad habits!"),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

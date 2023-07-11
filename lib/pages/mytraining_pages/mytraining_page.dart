import 'package:fitness_app/utils/app_utils.dart';
import 'package:fitness_app/widgets/custom_container_button.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/exercises_model.dart';

class MyTrainingPage extends StatelessWidget {
  final List<ExerciseModel> exercises;
  const MyTrainingPage({required this.exercises, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const TitleAppBar(leftText: "My", rightText: "Training")),
        body: Center(
          child: Column(
            children: [
              Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Row(children: [
                        const Icon(Icons.notification_important_outlined,
                            size: 30.0),
                        SizedBox(width: 10.w),
                        Container(
                            width: 270.w,
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Customize your own training plans base on your preferences!",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ))
                      ]))),
              const SizedBox(height: 250.0),
              InkWell(
                  onTap: () => Navigator.pushNamed(context, '/addExercises',
                      arguments: exercises),
                  child: const CustomContainerButton(
                      iconData: Icons.add,
                      backgroundColor: AppUtils.appbarBackgroundColor,
                      colorData: Colors.white)),
              const SizedBox(height: 10),
              Text(
                "Add Exercises",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}

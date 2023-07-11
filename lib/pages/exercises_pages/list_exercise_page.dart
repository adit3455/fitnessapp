import 'package:fitness_app/config/exercise_config.dart';
import 'package:fitness_app/extension/extension.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/title_app_bar.dart';
import 'exercise_detail_page.dart';

class ListExercisePage extends StatelessWidget {
  final List<ExerciseModel> exercise;
  const ListExercisePage({required this.exercise, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleAppBar(leftText: "List Of", rightText: "Exercise"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0.h),
            child: SingleChildScrollView(
                child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                    exercise.length > 20
                        ? "All Exercise"
                        : ExerciseConfig()
                            .exerciseTypeChanger(exercise[0].type),
                    style: Theme.of(context).textTheme.headlineSmall),
                Text("${exercise.length} Results",
                    style: Theme.of(context).textTheme.headlineSmall),
              ]),
              SizedBox(height: 10.h),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailPage(
                                index: index, exercise: exercise[index]),
                          )),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(exercise[index].image,
                              fit: BoxFit.fitWidth,
                              height: 130.h,
                              width: 100.w)),
                      title: Text(exercise[index].name),
                      subtitle: Text(
                          "1 Minute : ${exercise[index].calories.toInt()} Calories | Dificulities : ${exercise[index].dificulities.capitalize()}"),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: exercise.length)
            ]))));
  }
}

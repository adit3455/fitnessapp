import 'package:fitness_app/pages/mytraining_pages/accomodate_training_page.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:fitness_app/widgets/custom_container_button.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/exercises_model.dart';

class AddExercisePage extends StatelessWidget {
  final List<ExerciseModel> exercises;

  const AddExercisePage({required this.exercises, super.key});

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            title: const TitleAppBar(leftText: "Add", rightText: "Exercise")),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    customShowModalBottomSheet(
                        exercises[index], context, mQuery, exercises);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: CustomContainerButton(
                            iconData: Icons.add,
                            backgroundColor: AppUtils.appbarBackgroundColor,
                            colorData: Colors.white),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(exercises[index].image,
                                height: 80.h, width: 80.w, fit: BoxFit.fill)),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exercises[index].name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text(
                                exercises[index].duration!.replaceAll(".", ":"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.blue)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: exercises.length));
  }
}

Future<Padding?> customShowModalBottomSheet(ExerciseModel exercises,
    BuildContext context, Size mQuery, List<ExerciseModel> lExercises,
    {Row? bottomRow}) async {
  return showModalBottomSheet<Padding>(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: mQuery.height * 0.8,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5.0),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(exercises.image,
                      width: mQuery.width, height: 200, fit: BoxFit.fill)),
              const SizedBox(height: 10.0),
              Text(exercises.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Duration", style: Theme.of(context).textTheme.titleLarge),
                Row(children: [
                  InkWell(
                      onTap: () {},
                      child: const CustomContainerButton(
                          iconData: Icons.remove,
                          backgroundColor: Colors.white,
                          colorData: AppUtils.appbarBackgroundColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(exercises.duration.toString(),
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const CustomContainerButton(
                          iconData: Icons.add,
                          backgroundColor: Colors.white,
                          colorData: AppUtils.appbarBackgroundColor))
                ])
              ]),
              const SizedBox(height: 10.0),
              Text(
                exercises.instructions,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ]),
            bottomRow ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {}, child: const Text("Cancel")),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppUtils.appbarBackgroundColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccomodateExercisePage(
                                    exercises: lExercises),
                              ));
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
          ],
        ),
      );
    },
  );
}

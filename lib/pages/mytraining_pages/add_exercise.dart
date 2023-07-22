import 'package:fitness_app/blocs/my_training_bloc/my_training_bloc.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:fitness_app/widgets/custom_container_button.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/exercises_model.dart';

class AddExercisePage extends StatelessWidget {
  final List<ExerciseModel> exercises;

  const AddExercisePage({required this.exercises, super.key});

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        context.read<MyTrainingBloc>().add(NavigatorPopToGet());
        return true;
      },
      child: Scaffold(
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
                          exercises[index], context, mQuery);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: CustomContainerButton(
                              iconData: Icons.info_outline,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              Text(
                                  exercises[index]
                                      .duration!
                                      .replaceAll(".", ":"),
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
              itemCount: exercises.length)),
    );
  }
}

Future<Padding?> customShowModalBottomSheet(
    ExerciseModel exercise, BuildContext context, Size mQuery,
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
                  child: Image.network(exercise.image,
                      width: mQuery.width, height: 200, fit: BoxFit.fill)),
              const SizedBox(height: 10.0),
              Text(exercise.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              const SizedBox(height: 10.0),
              Text(
                exercise.instructions,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ]),
            bottomRow ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel")),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppUtils.appbarBackgroundColor),
                        onPressed: () {
                          context.read<MyTrainingBloc>().add(
                              AddToAcomodateExerciseEvent(
                                  exerciseModel: exercise));
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/accomodateExercises');
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

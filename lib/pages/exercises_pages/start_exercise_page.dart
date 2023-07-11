import 'package:fitness_app/models/exercises_model.dart';
import 'package:fitness_app/pages/exercises_pages/exercise_detail_page.dart';
import 'package:fitness_app/pages/exercises_pages/on_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/start_exercise_bloc/start_exercise_bloc.dart';
import '../../config/exercise_config.dart';
import '../../utils/app_utils.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/title_app_bar.dart';

class StartExercisePage extends StatelessWidget {
  final List<ExerciseModel> exercise;
  const StartExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    ExerciseConfig exerciseConfig = ExerciseConfig();

    return Scaffold(
        appBar: AppBar(
            title: const TitleAppBar(
                leftText: "Start Your", rightText: "Exercise?")),
        floatingActionButton:
            BlocConsumer<StartExerciseBloc, StartExerciseState>(
          listener: (context, state) {
            if (state is NavigateExercise) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnExercisePage()));
            }
          },
          builder: (context, state) {
            if (state is NavigateExercise) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnStartExercise) {
              return CustomButtonWidget(
                  labelButton: "Start",
                  icon: Icons.stacked_line_chart_sharp,
                  onPressed: () => context.read<StartExerciseBloc>()
                    ..add(OnStartExercise(exercise, 0)));
            }
            return const Text("Theres Something Wrong");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppUtils.appbarBackgroundColor,
                AppUtils.gradientRightBackgroundColorDetailNutrition
              ])),
              child: Stack(children: [
                Positioned(
                    top: 20.h,
                    left: 30.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: 300.w,
                            exercise[2].image))),
                Positioned(
                    bottom: -5.h,
                    child: Container(
                        height: 25.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                            color: Colors.white)))
              ])),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                IntrinsicHeight(
                    child: Row(children: [
                  Text(
                      "${exerciseConfig.durationStarter(exercise)} Mins Duration",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w500)),
                  const VerticalDivider(),
                  Text("${exercise.length} Exercises",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w500))
                ])),
                SizedBox(height: 20.h),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExerciseDetailPage(
                                    index: index, exercise: exercise[index]))),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(exercise[index].image,
                                fit: BoxFit.fitWidth,
                                height: 130.h,
                                width: 100.w)),
                        title: Text(
                          exercise[index].name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        subtitle: Text(
                          "${exercise[index].duration?.replaceAll(".", ":")} Second",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppUtils.gradientRightBackgroundColor),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: exercise.length),
                SizedBox(height: 80.h),
              ]))
        ])));
  }
}

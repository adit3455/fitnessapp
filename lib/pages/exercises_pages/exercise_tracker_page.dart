import 'package:fitness_app/config/exercise_config.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:fitness_app/widgets/custom_card_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/fetch_exercise_bloc/fetch_exercise_bloc.dart';
import '../../repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import '../../utils/app_utils.dart';
import '../../utils/assets_util.dart';
import '../../widgets/custom_bold_title.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/start_fitness_widget.dart';
import '../../widgets/title_app_bar.dart';

class ExerciseTrackerPage extends StatelessWidget {
  const ExerciseTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    ExerciseConfig exerciseConfig = ExerciseConfig();
    return Scaffold(
        appBar: AppBar(
          title: const TitleAppBar(leftText: "Exercise", rightText: "Tracker"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: BlocProvider(
                create: (context) => FetchExerciseBloc(
                    firebaseExerciseModule: FirebaseExerciseModule())
                  ..add(LoadExercise()),
                child: BlocConsumer<FetchExerciseBloc, FetchExerciseState>(
                    listener: (context, state) {
                  if (state is ExerciseError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                }, builder: (context, state) {
                  if (state is ExerciseLoading) {
                    return const LoadingWidget(count: 10);
                  }
                  if (state is ExerciseLoaded) {
                    final List<ExerciseModel> lower = exerciseConfig
                        .listByTyping(state.listExercise, "lbworkout");
                    final List<ExerciseModel> upper = exerciseConfig
                        .listByTyping(state.listExercise, "ubworkout");
                    final List<ExerciseModel> full = exerciseConfig
                        .listByTyping(state.listExercise, "fbworkout");

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200.h,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                AppUtils.appbarBackgroundColor,
                                AppUtils
                                    .gradientRightBackgroundColorDetailNutrition
                              ])),
                              child: Stack(children: [
                                Positioned(
                                    top: 20.h,
                                    left: 30.w,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                            fit: BoxFit.cover,
                                            height: 200.h,
                                            width: 300.w,
                                            AssetsUtil.eighteenPerson))),
                                Positioned(
                                    bottom: -5.h,
                                    child: Container(
                                      height: 25.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30.0)),
                                          color: Colors.white),
                                    ))
                              ])),
                          Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StartFitnessWidget(
                                        title: "Start Your Exercise Now?",
                                        subTitle: const SizedBox(),
                                        onTap: () => Navigator.pushNamed(
                                            context, '/startExercise',
                                            arguments: exerciseConfig
                                                .startExerciseList(
                                                    state.listExercise))),
                                    SizedBox(height: 10.h),
                                    const CustomBoldTitle(
                                        title: "Create your own Exercise!"),
                                    CustomCardHomePage(
                                        image: AssetsUtil.runBoy,
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/myTraining',
                                            arguments: state.listExercise),
                                        labelText: "My Training"),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomBoldTitle(
                                            title: "The Workouts"),
                                        TextButton(
                                          onPressed: () => Navigator.pushNamed(
                                              context, '/listExercise',
                                              arguments: state.listExercise),
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(10.h)),
                                          child: const Text("See All"),
                                        )
                                      ],
                                    ),
                                    StartFitnessWidget(
                                        title: "Full Body Workout",
                                        labelButton: "View",
                                        isUserImageNetwork: true,
                                        imageNetwork: full[0].image,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/listExercise',
                                            arguments: full),
                                        subTitle: SizedBox(
                                            width: 160.w,
                                            child: Text(
                                                "${full.length} Exercises | ${exerciseConfig.sumList(full)} Total Calories in Each Minutes",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: Colors.white)))),
                                    SizedBox(height: 10.h),
                                    StartFitnessWidget(
                                        title: "Upper Body Workout",
                                        labelButton: "View",
                                        isUserImageNetwork: true,
                                        imageNetwork: upper[0].image,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/listExercise',
                                            arguments: upper),
                                        subTitle: SizedBox(
                                            width: 160.w,
                                            child: Text(
                                                "${upper.length} Exercises | ${exerciseConfig.sumList(upper)} Total Calories in Each Minutes",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: Colors.white)))),
                                    SizedBox(height: 10.h),
                                    StartFitnessWidget(
                                        title: "Lower Body Workout",
                                        labelButton: "View",
                                        isUserImageNetwork: true,
                                        imageNetwork: lower[0].image,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/listExercise',
                                            arguments: lower),
                                        subTitle: SizedBox(
                                            width: 160.w,
                                            child: Text(
                                                "${lower.length} Exercises | ${exerciseConfig.sumList(lower)} Total Calories in Each Minutes",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: Colors.white)))),
                                    SizedBox(height: 10.h),
                                  ])),
                        ]);
                  }

                  return const Text("Theres Something Wrong");
                }))));
  }
}

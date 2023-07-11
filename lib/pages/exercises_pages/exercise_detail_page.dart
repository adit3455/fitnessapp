import 'package:card_loading/card_loading.dart';
import 'package:fitness_app/extension/extension.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/fetch_exercise_bloc/fetch_exercise_bloc.dart';
import '../../config/exercise_config.dart';
import '../../repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import '../../utils/app_utils.dart';
import '../../widgets/custom_bold_title.dart';
import '../../widgets/title_app_bar.dart';

class ExerciseDetailPage extends StatelessWidget {
  final ExerciseModel exercise;
  final int index;
  const ExerciseDetailPage(
      {required this.index, required this.exercise, super.key});

  @override
  Widget build(BuildContext context) {
    ExerciseConfig exerciseConfig = ExerciseConfig();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const TitleAppBar(leftText: "Exercise", rightText: "Detail"),
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            fit: BoxFit.fill,
                            height: 200.h,
                            width: 300.w,
                            exercise.image))),
                Positioned(
                    bottom: -5.h,
                    child: Container(
                      height: 25.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30.0)),
                          color: Colors.white),
                    ))
              ])),
          Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 270.w,
                            child: CustomBoldTitle(
                                title: exercise.name, paddingSize: 0)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite, color: Colors.red))
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                        "Dificulities : ${exercise.dificulities.capitalize()} | Calories Burn in 1 Minutes : ${exercise.calories.toInt()} Calories | ${exerciseConfig.exerciseTypeChanger(exercise.type)}"),
                    const SizedBox(height: 5.0),
                    Container(
                        margin: EdgeInsets.all(5.h),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey.shade300),
                        child: Text(exercise.instructions,
                            style: Theme.of(context).textTheme.bodyLarge)),
                    SizedBox(height: 5.h),
                    const CustomBoldTitle(
                        title: "Check Other Exercise !", paddingSize: 0),
                    SizedBox(height: 5.h),
                    BlocProvider(
                        create: (context) => FetchExerciseBloc(
                            firebaseExerciseModule: FirebaseExerciseModule())
                          ..add(LoadExercise()),
                        child: SizedBox(
                            height: 200.h,
                            child: BlocConsumer<FetchExerciseBloc,
                                FetchExerciseState>(listener: (context, state) {
                              if (state is ExerciseError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)));
                              }
                            }, builder: (context, state) {
                              if (state is ExerciseLoading) {
                                return CardLoading(height: 200.h, width: 200.w);
                              }
                              if (state is ExerciseLoaded) {
                                List<ExerciseModel> stateList = exerciseConfig
                                    .listFiltered(state.listExercise, exercise);

                                return ListView.builder(
                                    itemCount: stateList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseDetailPage(
                                                        index: index,
                                                        exercise:
                                                            stateList[index]),
                                              )),
                                          splashColor: AppUtils
                                              .gradientRightBackgroundColor,
                                          child: Container(
                                              padding: EdgeInsets.all(3.h),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              width: 250.w,
                                              child: Stack(children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    decoration: const BoxDecoration(
                                                        color: AppUtils
                                                            .appbarBackgroundColor),
                                                    child: Image.network(
                                                        stateList[index].image,
                                                        width: 240.w,
                                                        height: 120.h,
                                                        fit: BoxFit.cover)),
                                                Positioned(
                                                    top: 140.h,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                      1),
                                                              width: 240.w,
                                                              child: Text(
                                                                  stateList[index]
                                                                      .name,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headlineSmall!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .bold),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis)),
                                                          const SizedBox(
                                                              height: 5),
                                                          SizedBox(
                                                              width: 240.w,
                                                              child: Text(
                                                                  "1 Minute : ${stateList[index].calories.toInt()} Calories | Dificulities : ${stateList[index].dificulities.capitalize()}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          letterSpacing:
                                                                              0)))
                                                        ]))
                                              ])));
                                    });
                              }
                              return const Text("Theres Something Wrong");
                            })))
                  ]))
        ])));
  }
}

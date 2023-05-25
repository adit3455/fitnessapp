import 'package:fitness_app/models/bad_habits_model.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../repository/export_repo.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widgets.dart';

class BadHabbitsPage extends StatelessWidget {
  const BadHabbitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const TitleAppBar(leftText: "Bad", rightText: "Habbits"),
        ),
        body: BlocProvider(
            create: (context) => FetchBadHabitBloc(
                badHabitsFirebaseService: BadHabitsFirebaseService())
              ..add(LoadBadHabit()),
            child: BlocConsumer<FetchBadHabitBloc, FetchBadHabitState>(
                listener: (context, state) {
              if (state is BadHabitError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            }, builder: (context, state) {
              return SingleChildScrollView(
                  child: BlocConsumer<FetchBadHabitBloc, FetchBadHabitState>(
                      listener: (context, state) {
                if (state is BadHabitError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              }, builder: (context, state) {
                if (state is BadHabitLoading) {
                  return const LoadingWidget(count: 10);
                }
                if (state is BadHabitLoaded) {
                  BadHabitsModel habitModel = state.badHabitsModel;
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                          fit: BoxFit.cover,
                                          height: 200.h,
                                          width: 300.w,
                                          AssetsUtil.stopSmoking))),
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
                            padding: EdgeInsets.all(10.0.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomBoldTitle(
                                      title: "Stay Away From Bad Habbits"),
                                  _greyBoxText(habitModel.description, context),
                                  const CustomBoldTitle(
                                      title:
                                          "Social Norms on Smoking and Drinking"),
                                  _greyBoxText(habitModel.socialNorms, context),
                                  const CustomBoldTitle(
                                      title:
                                          "How can I Help Myself cut Down or Quit"),
                                  _greyBoxText(
                                      habitModel.quitSmoking?.first, context),
                                  ...List.generate(
                                      habitModel.quitSmoking!.second!.length,
                                      (index) => BulletText(
                                          text: habitModel
                                              .quitSmoking!.second![index])),
                                  _greyBoxText(
                                      habitModel.quitSmoking?.third, context),
                                  ...List.generate(
                                      habitModel.quitSmoking!.fourth!.length,
                                      (index) => BulletText(
                                          text: habitModel
                                              .quitSmoking!.fourth![index])),
                                  _greyBoxText(
                                      habitModel.quitSmoking?.five, context),
                                ])),
                      ]);
                }
                return const Text("Theres Something Wrong");
              }));
            })));
  }

  Container _greyBoxText(String? text, BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.h),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade300),
        child: Text("$text", style: Theme.of(context).textTheme.bodyLarge));
  }
}

import 'package:fitness_app/widgets/custom_bold_title.dart';
import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../blocs/start_exercise_bloc/start_exercise_bloc.dart';
import '../../config/exercise_config.dart';
import '../../utils/app_utils.dart';
import '../../utils/assets_util.dart';

class DoneExerciseScreen extends StatelessWidget {
  const DoneExerciseScreen({super.key});
  String strDigits(int n) => n.toString().padLeft(2, '0');
  String minutes(Duration d) => strDigits(d.inMinutes.remainder(60));
  String seconds(Duration d) => strDigits(d.inSeconds.remainder(60));
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              bottomOpacity: 0,
              leading: const SizedBox(),
              backgroundColor: AppUtils.appbarBackgroundColor),
          body: BlocBuilder<StartExerciseBloc, StartExerciseState>(
            builder: (context, state) {
              if (state is UnStartExercise) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DoneExerciseState) {
                final kcal = state.accomodateExercise.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + element.calories.toInt());

                Duration getDuration() {
                  final durationSeconds = state.accomodateExercise.fold(
                      0,
                      (previousValue, element) =>
                          previousValue +
                          ExerciseConfig()
                              .durationConverter(element.duration!)
                              .inSeconds);
                  return Duration(seconds: durationSeconds);
                }

                final String dateTimeNow =
                    DateFormat.yMMMMEEEEd().format(DateTime.now());

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 170.h,
                        width: mQuery.width,
                        color: AppUtils.appbarBackgroundColor,
                        child: Stack(
                            fit: StackFit.loose,
                            clipBehavior: Clip.antiAlias,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20.w),
                                  alignment: Alignment.topRight,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(AssetsUtil.runBoy,
                                          fit: BoxFit.cover,
                                          width: 100.w,
                                          height: 100.h))),
                              Positioned(
                                left: 25.w,
                                top: 5.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(children: [
                                      Icon(
                                        Icons.thumb_up,
                                        color: Colors.white,
                                      ),
                                      CustomBoldTitle(
                                        title: "You Rock!",
                                        textColor: Colors.white,
                                      )
                                    ]),
                                    Text("Exercise Finished!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                color: Colors.grey.shade100)),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 20.h,
                                child: SizedBox(
                                  width: mQuery.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      stackColumn(
                                          context,
                                          "${state.accomodateExercise.length}",
                                          "Exercises"),
                                      stackColumn(context, "$kcal", "Kcal"),
                                      stackColumn(
                                          context,
                                          "${minutes(getDuration())}:${seconds(getDuration())}",
                                          "Duration"),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),
                              CustomBoldTitle(
                                  fontSize: 20.0, title: dateTimeNow),
                              const SizedBox(height: 20.0),
                              _listTileDoneExercise(context,
                                  title: "Reminder",
                                  subTitle: "06:00",
                                  trailing: IconButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/setReminder'),
                                      icon: const Icon(Icons.edit))),
                              const SizedBox(height: 20.0),
                              _listTileDoneExercise(context,
                                  title: "Exercised You Done!",
                                  subTitle: "Check it here!",
                                  onTap: () => state
                                          .accomodateExercise.isNotEmpty
                                      ? Navigator.pushNamed(
                                          context, '/listExercise',
                                          arguments: state.accomodateExercise)
                                      : dialogEmptyExercise(context),
                                  trailing: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(AssetsUtil.manWomanPose,
                                        fit: BoxFit.cover),
                                  )),
                              SizedBox(height: 50.0.h),
                              Center(
                                child: CustomButtonWidget(
                                  labelButton: "Back To Home",
                                  icon: Icons.home_outlined,
                                  onPressed: () async {
                                    context.read<StartExerciseBloc>().add(InitState(
                                        date: dateTimeNow,
                                        duration: state.accomodateExercise.fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                ExerciseConfig()
                                                    .durationConverter(
                                                        element.duration!)
                                                    .inSeconds),
                                        totalCalories: kcal.toDouble(),
                                        accommodateExercise:
                                            state.accomodateExercise));
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/bottom', (route) => false);
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                );
              }
              return const Text("Theres Something Wrong");
            },
          )),
    );
  }

  void dialogEmptyExercise(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("Alert!"),
          content: const Text("You haven't do any exercises!"),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0)),
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"))
          ],
        ),
      );

  ListTile _listTileDoneExercise(BuildContext context,
      {Widget? trailing,
      required String title,
      Widget? leading,
      Color? tileColor,
      void Function()? onTap,
      required String subTitle}) {
    return ListTile(
        leading: leading ?? const SizedBox(),
        iconColor: Colors.white,
        tileColor: tileColor ?? AppUtils.appbarBackgroundColor,
        onTap: onTap,
        minVerticalPadding: 20.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        trailing: trailing ?? const SizedBox());
  }

  Column stackColumn(
      BuildContext context, final String upperText, final String downText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(upperText,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(downText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade100)),
      ],
    );
  }
}
